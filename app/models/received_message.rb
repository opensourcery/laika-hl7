class ReceivedMessage < ActiveRecord::Base
  has_many :validation_errors
  
  def name
    begin
      msg = HL7::Message.new(self.message_contents)
      if msg[:PID]
          display_name = case(msg[:PID])
                           when(Array)
                             msg[:PID].first.patient_name
                           when(HL7::Message::Segment::PID)
                             msg[:PID].patient_name
                         end
                         
          if display_name.blank?
            'No patient name provided'
          else
            display_name
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
      case(msg[:PID])
        when(Array)
          self.validation_errors << ValidationError.new(:message => 'Got more than one PID segment')
        when(HL7::Message::Segment::PID)
          patient_to_match = Patient.find_by_identifier(msg[:PID].patient_id_list)
          if patient_to_match

            error_list = patient_to_match.validate_message(msg)

            unless error_list.empty?
              self.validation_errors = error_list
            end

          else
            self.validation_errors << ValidationError.new(:message => 'Unable to find a matching patient')
          end
        when(nil)
          self.validation_errors << ValidationError.new(:message => 'No PID segment provided')
      end

    rescue HL7::Exception
      self.validation_errors << ValidationError.new(:message => 'Unable to parse the message')
    end
  end
end
