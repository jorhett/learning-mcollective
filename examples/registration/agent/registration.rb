module MCollective
  module Agent
    class Registration
      attr_reader :timeout, :meta

      require 'time'
      def initialize
        @timeout = 1

        @config = Config.instance

        @meta = {:license => "GPLv2",
          :author => "Jo Rhett <jrhett@netconsonance.com>",
          :url => "http://www.netconsonance.com/learning-mcollective-book/"}
      end

      def handlemsg(message, connection)

        remotetime = Time.at( message[:msgtime] )
        Log.info("server " + message[:senderid] + " sent us registration with timestamp " + remotetime.to_s)

        return nil
      end

      def help
        <<-END
LogOnly Registration Agent
==========================

A simple registration agent that writes out one log line for each server
that it receives a registration message from.
END
      end
    end
  end
end
