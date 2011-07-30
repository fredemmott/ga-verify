require 'ga_verify/thrift'
require 'ga_verify/paths'

require 'rotp'

module GAVerify
  class Handler
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

      secret = File.open(path, 'r').first.strip
      totp = ROTP::TOTP.new(secret)

      now = Time.now.to_i
      times = [now - 60, now, now + 60]

      if times.any?{|time| totp.verify(token, time)}
        return GAVerify::Result::SUCCESS
      else
        return GAVerify::Result::BAD_TOKEN
      end
    end
  end
end
