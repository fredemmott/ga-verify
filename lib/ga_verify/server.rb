# Copyright 2011-present Fred Emmott. See COPYING file.
require 'ga_verify/handler'

require 'thrift'

module GAVerify
  class Server < GAVerify::Handler
    def initialize socket_path
      handler   = GAVerify::Handler.new
      processor = GAVerify::Verifier::Processor.new handler
      transport = Thrift::FramedTransportFactory.new
      socket    = Thrift::UNIXServerSocket.new(socket_path)
      @server   = Thrift::NonblockingServer.new processor, socket, transport
    end

    def serve!
      @server.serve
    end
  end
end
