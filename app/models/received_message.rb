class ReceivedMessage < ActiveRecord::Base
  def name
    msg = HL7::Message.new( self.message_contents )
    msg[:PID].patient_name
  end
end
