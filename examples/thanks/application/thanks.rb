class MCollective::Application::Thanks<MCollective::Application
  description "Sends a thanks message before grabbing a towel."
  usage "mco thanks [ACTION] [OPTIONS]"
  usage "ACTION: is one of 'say_goodbye' or 'get_towel'"

  # This options parser updates the help page
  option :person,
         :description => "The person the dolphins say Goodbye to.",
         :arguments   => ["-p NAME", "--person NAME"],
         :type        => String,
         :require     => true

  # this is a hook called right after option parsing
  def post_option_parser(configuration)
    # we could test or manipulate input values here
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift                                                                                                                                                                          
    end

    raise "Action must be say_goodbye or get_towel" unless ["say_goodbye", "get_towel"].include?(configuration[:command])
  end

  # another hook where we could throw exceptions if the input isn't valid
  def validate_configuration(configuration)
    raise "Need to have a Person to say goodbye to." unless configuration.include?(:person)
  end

  # Now we enter main processing
  def main
    client = rpcclient("thanks")
    printrpc client.send( configuration[:command], :person => configuration[:person], :options => options )

    # Exit using halt and it will pass on the appropriate exit code
    printrpcstats
    halt client.stats
  end
end
