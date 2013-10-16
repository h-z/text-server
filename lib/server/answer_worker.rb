class TextServer::Server::AnswerWorker
  include Celluloid

  # @param [Context] context
  def initialize context
    @context = context
  end

  # @param [TCPSocket] client
  def start(client)
    @client = client
    lines = []
    loop do
      begin
        line = client.gets.gsub(/[\r\n]+$/, '')
      rescue
        raise StopIteration
      end
      if line.nil? or 'end' == line
        raise StopIteration
      end
      lines << line
    end

    [work_on(lines)].flatten.each do |line|
      client.write line.to_s + "\n"
    end
    client.close
  end

  # @param [Array] lines
  # @return [Hash]
  def work_on lines
    params = {}
    lines.each do |line|
      splitted = line.split(':')
      params[splitted[0]] = splitted[1]
    end
    cmd = params.delete('cmd')

    @context.server.get_command(cmd).new(@context).do(params)
  end
end
