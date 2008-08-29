class ReceivedMessage < ActiveRecord::Base
  has_many :validation_errors
  
  def name
    msg = HL7::Message.new(self.message_contents)
    msg[:PID].patient_name
  end
  
  def valid_hl7_message?
    self.validation_errors.empty?
  end
  
  def validate_hl7_message
    begin
      msg = HL7::Message.new(self.message_contents)
      patient_to_match = Patient.find_by_identifier(msg[:PID].patient_id_list)
      if patient_to_match
        
        # Validation of the message goes here!
        
      else
        self.validation_errors << ValidationError.new(:message => 'Unable to find a matching patient')
      end
    rescue HL7::Exception
      self.validation_errors << ValidationError.new(:message => 'Unable to parse the message')
    end
  end
end
