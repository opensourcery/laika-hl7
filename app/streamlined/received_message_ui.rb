module ReceivedMessageAdditions
  def see_raw_message
    "<a href=\"/received_messages/raw_message/#{self.id}\">See raw HL7 Message</a>"
  end
  
  def passed_validation
    self.valid_hl7_message?
  end
end
ReceivedMessage.class_eval { include ReceivedMessageAdditions }

Streamlined.ui_for(ReceivedMessage) do
  user_columns :name, :created_at, :passed_validation,
               :see_raw_message, {:allow_html => true}
end   
