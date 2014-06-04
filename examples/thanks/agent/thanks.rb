module MCollective
  module Agent
    class Thanks<RPC::Agent
      action "say_goodbye" do
        person = validate_input
        
        # Retrieve a configuration parameter
        delicacy = @config.pluginconf.fetch("thanks.delicacy", 'fish')

        reply[:message] = sprintf( "Goodbye %s, and thanks for all the %s!\n", person, delicacy ) 
      end

      action "get_towel" do
        person = validate_input
        reply[:message] = sprintf( "I got my towel. Seeya %s!\n", person ) 
      end

      def validate_input
        # Get the input
        validate :person, String
        person = request.data[:person]

        # This will set statuscode and statusmsg fields in the reply
        reply.fail "Who should I say goodbye to?", 1 if person == ''
        exit 1 unless reply.statuscode == 0

        return person
      end

    end
  end
end
