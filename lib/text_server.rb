$:.unshift File.dirname(__FILE__) + '/server'
$:.unshift File.dirname(__FILE__) + '/commands'
module TextServer
  module Commands
  end
  module Server
  end
end
require 'commands/command'
require 'server/base_server'
require 'server/context'
require 'server/answer_worker'
require 'commands/echo'
require 'commands/reverse'

