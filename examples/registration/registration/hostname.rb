module MCollective
  module Registration
    # A registration plugin that simply sends the hostname
    class Hostname<Base
      require 'socket'
      def body
        Socket.gethostname
      end
    end
  end
end
