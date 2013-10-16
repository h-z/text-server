class TextServer::Commands::Echo < TextServer::Commands::Command
  responds_to :echo

  register_as_command

  def do lines
    lines.keys
  end
end