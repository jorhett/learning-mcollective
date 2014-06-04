metadata :name        => "Thanks",
         :description => "Agent to say thanks and grab a towel",
         :author      => "Dolphins",
         :license     => "Taken",
         :version     => "1.0",
         :url         => "http://en.wikipedia.org/wiki/The_Hitchhiker's_Guide_to_the_Galaxy‎",
         :timeout     => 10    # how long before killing off the request

requires :mcollective => "2.4.0"

action "say_goodbye", :description => "Says Goodbye" do
  display :always   # could be :ok or :failed

  input :person,
        :prompt      => "Person's Name",
        :description => "The name of the person we are saying goodbye to.",
        :type        => :string,             # could be :number, :integer, :float, :list, or :boolean
        #:list       => ["value1","value2"], # only for type = :list
        :validation  => '^[A-Za-z\s]+',      # only for type = :string
        :maxlength   => 20,                  # only for type = :string
        :optional    => false,
        :default     => "Arthur"

 output :message,
        :description => "The response",
        :display_as  => "Message",
        :default     => "Goodbye, fish, thanks!"
end

action "get_towel", :description => "Gets Towel" do
  display :always   # could be :ok or :failed

  input :person,
        :prompt      => "Person's Name",
        :description => "The name of the person we are saying goodbye to.",
        :type        => :string,             # could be :number, :integer, :float, :list, or :boolean
        #:list       => ["value1","value2"], # only for type = :list
        :validation  => '^[A-Za-z\s]+',      # only for type = :string
        :maxlength   => 20,                  # only for type = :string
        :optional    => false,
        :default     => "Arthur"

 output :message,
        :description => "The response",
        :display_as  => "Message",
        :default     => "Goodbye, fish, thanks!"
end
