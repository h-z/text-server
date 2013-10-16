require 'socket'
require 'celluloid'
$:.unshift File.dirname(__FILE__)
require 'text_server'


ts = TextServer::Server::BaseServer.new 3000

ts.start
