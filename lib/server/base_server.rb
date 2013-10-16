require 'answer_worker'
require 'context'
require 'celluloid'

class TextServer::Server::BaseServer
  include Celluloid

  # @return [Integer]
  def pool_size
    5
  end

  # @param [Integer] port
  def initialize(port)
    @port = port
    @commands = {}
  end

  # @param [Class] command
  # @return [Array<Command>]
  def add_command command
    @commands[command.cmd] = command if command.ancestors.include?(TextServer::Commands::Command)
    @commands
  end

  # @return [Hash]
  def commands
    @commands
  end

  # @param [String] cmd
  # @return [Command]
  def get_command cmd
    command = commands[cmd]
    if command.nil?
      TextServer::Commands::Command
    else
      command
    end
  end

  def start
    TextServer::Commands::Command.commands.each do |command|
      add_command command
    end
    @server = TCPServer.new('localhost', @port)
    pool = TextServer::Server::AnswerWorker.pool(size: pool_size, args: TextServer::Server::Context.new(self))
    puts 'pool started'
    loop do
      pool.async.start(@server.accept)
    end
  end
end
