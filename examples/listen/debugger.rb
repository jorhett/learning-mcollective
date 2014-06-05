# Block of required includes that makes us an MCollective client
require 'mcollective'
require 'pp'

Log = MCollective::Log

optparser = MCollective::Optionparser.new
options = optparser.parse

config = MCollective::Config.instance
config.loadconfig(options[:config])

MCollective::PluginManager["security_plugin"].initiated_by = :client

connector = MCollective::PluginManager['connector_plugin']
connector.connect

# Get a reply queue name from anywhere, hardcoded here
replyqueue = ARGV[0] || 'debugger'

# Default collective reply queue name appropriate for ActiveMQ
#   something different would be required for other connectors
queuename = '/queue/mcollective.reply.' + replyqueue

# Here is the queue we want to listen to
connector.connection.subscribe( queuename, {}, "$$".to_i )

# consume all the things...
loop do
  # Get an mcollective Message object and configure it as a reply
  message = connector.receive
  message.type = :reply
  message.decode!          # security plugin validates authentication
 
  # Get the autenticated sender from the envelope
  sender = message.payload[:senderid]
  agent = message.payload[:senderagent]
  body = message.payload[:body]
 
  # Only use one of these, as each includes the ones beneath it.
  # - All the gory details
  #pp message

  # - Everything we care about is here 
  #pp message.payload

  # - This contains just the data in the response
  pp message.payload[:body]

  # Are we normally shaped reply with a statusmsg?
  if( body[:statusmsg] )
    puts sender.to_s + '/' + agent.to_s + ': ' + body[:statusmsg].to_s + '=' + body[:statuscode].to_s
    if( body[:data].class == Hash )
      pp body[:data]
    else
      pp body
    end
  else
    # things which don't send us a status just pretty-print the body
    print sender.to_s + ': '
    pp body
  end
end
