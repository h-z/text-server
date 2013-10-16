class TextServer::Commands::Reverse < TextServer::Commands::Command
  responds_to :rev
  register_as_command

  def do lines
    lines.keys.collect { |line| line.reverse }
  end
end