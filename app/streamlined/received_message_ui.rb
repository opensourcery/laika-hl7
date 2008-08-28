module ReceivedMessageAdditions
  def see_raw_message
    "<a href=\"/received_messages/raw_message/#{self.id}\">See raw HL7 Message</a>"
  end
end
ReceivedMessage.class_eval { include ReceivedMessageAdditions }

Streamlined.ui_for(ReceivedMessage) do
  user_columns :name, :created_at, 
               :see_raw_message, {:allow_html => true}
end   
