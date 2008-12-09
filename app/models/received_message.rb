class ReceivedMessage < ActiveRecord::Base
  has_many :validation_errors
  
  def name
    begin
      msg = HL7::Message.new(self.message_contents)
      if msg[:PID]
        if msg[:PID].patient_name.blank?
          'No patient name provided'
        else
          msg[:PID].patient_name
        end
      else
        'Could not find PID Segment in message'
      end
    rescue HL7::Exception
      'Unable to parse message'
    end
  end
  
  def valid_hl7_message?
    self.validation_errors.empty?
  end
  
  def validate_hl7_message
    begin
      msg = HL7::Message.new(self.message_contents)
      patient_to_match = Patient.find_by_identifier(msg[:PID].patient_id_list)
      if patient_to_match
        
        error_list = patient_to_match.validate_message(msg)
        
        unless error_list.empty?
          self.validation_errors = error_list
        end
        
      else
        self.validation_errors << ValidationError.new(:message => 'Unable to find a matching patient')
      end
    rescue HL7::Exception
      self.validation_errors << ValidationError.new(:message => 'Unable to parse the message')
    end
  end
end
