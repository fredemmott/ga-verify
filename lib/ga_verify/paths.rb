# Copyright 2011-present Fred Emmott. See COPYING file.
module GAVerify
  module Paths
    def self.default_socket
      '/var/run/ga_verifyd.sock'
    end

    def self.config_path user
      "/home/#{user}/.google_authenticator"
    end
  end
end
