require 'ga_verify/thrift'
require 'ga_verify/paths'

require 'rotp'

module GAVerify
  class Handler
    def initialize
      @last_seen   = Hash.new(0)
      @used_tokens = Hash.new{Hash.new(0)}
    end

    def check_user user, token
      unless user =~ /^[a-z]+$/
        return GAVerify::Result::BAD_USER
      end
      unless File.exists? "/home/#{user}"
        return GAVerify::Result::BAD_USER
      end
      path = GAVerify::Paths.config_path(user)
      unless File.exists? path
        return GAVerify::Result::NO_GOOGLE_AUTH
      end
      now = Time.now.to_i
      # Max one login every 15s
      if @last_seen[user] >= now - 15
        return GAVerify::Result::BAD_TOKEN
      end
      @last_seen[user] = now

      secret = File.open(path, 'r').first.strip
      totp = ROTP::TOTP.new(secret)

      # Allow +- 1 token
      times = [now - 30, now, now + 30]
      if times.any?{|time| totp.verify(token, time)}
        # disallow token re-use within 10 minutes
        if @used_tokens[user][token] < now - 600
          @used_tokens[user][token] = now
          # Cleanup
          @used_tokens[user].reject!{|k,v| used_tokens[user][token] < now - 600}
          return GAVerify::Result::SUCCESS
        end
      end
      return GAVerify::Result::BAD_TOKEN
    end
  end
end
