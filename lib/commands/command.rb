class TextServer::Commands::Command
  @@registered_commands = []

  # @param [ServerContext] context
  def initialize context
    @context = context
  end

  # @param [Symbol] sym
  def self.responds_to sym
    @cmd = sym.to_s
  end

  def self.register_as_command
    @@registered_commands << self
  end

  def self.commands
    @@registered_commands
  end

  def self.cmd
    @cmd
  end

  responds_to :undefined

  # @param [Hash] lines
  def do lines
    ['cmd']
  end
end
