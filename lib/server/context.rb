class TextServer::Server::Context
  attr_reader :server

  # @param [TextServer]
  def initialize server
    @server = server
  end
end
