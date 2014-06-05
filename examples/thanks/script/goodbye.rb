#!/usr/bin/ruby
require 'mcollective'
include MCollective::RPC

options = rpcoptions do |parser, options|
  parser.define_head "Tester for the Thanks agent"
  parser.banner = "Usage: client-saygoodbye [options] --person NAME"

  parser.on('-p', '--person NAME', 'Name of the person to say goodbye to.') do |name|
    options[:person] = name
  end

# We'll need this when MCO-207 is acted upon
#  parser.on('--reply-to QUEUE', 'Set a target queue for results to be sent to.') do |queue|
#    options[:reply_to] = queue
#  end
end

# This is probably covered by the validation in the DDL
unless options.include?(:person)
  puts("You need to specify a person's name with --person")
  exit! 1
end

# Create an MCollective client utilizing our agent
client = rpcclient("thanks", :options => options)

# Optionally send results to a reply queue
if options.include?(:reply_to)
  client.reply_to = options[:reply_to]
end

# If we want to see discovery results
client.discover :verbose => true

# If we want to disable the progress indicator
#client.progress = false

# Simple verbose output
#printrpc client.say_goodbye(:person => options[:person]), :verbose => true
#printrpcstats

# we don't get any data back if results go to a queue
if options.include?(:reply_to)
  client.say_goodbye(:person => options[:person])
else
  # Format the output
  client.say_goodbye(:person => options[:person]).each do |resp|
    printf("%-10s: %s\n", resp[:sender], resp[:data][:message])
  end
end

# Get the stats object from the request
#client.say_goodbye( :person => options[:person] )
#print "No response from: " + client.stats.no_response_report + "\n"  # nodes which didn't respond
#client.stats.to_hash.each {|key, value| puts "#{key} = #{value}" }

# Output the request statistics
print client.stats.report
print "\n"
client.disconnect
