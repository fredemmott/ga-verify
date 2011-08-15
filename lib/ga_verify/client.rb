# Copyright 2011-present Fred Emmott. See COPYING file.
require 'ga_verify/thrift'
require 'ga_verify/paths'

require 'thrift'

module GAVerify
  class Client
    def initialize options={}
      options[:socket] ||= GAVerify::Paths.default_socket 
      socket    = Thrift::UNIXSocket.new(options[:socket])
      transport = Thrift::FramedTransport.new(socket)
      protocol  = Thrift::BinaryProtocol.new(transport)
      @client   = GAVerify::Verifier::Client.new(protocol)
      transport.open
    end

    def method_missing *args
      @client.send *args
    end
  end
end
