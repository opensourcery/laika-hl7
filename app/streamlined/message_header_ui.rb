module MessageHeaderAdditions

end
MessageHeader.class_eval { include MessageHeaderAdditions }

Streamlined.ui_for(MessageHeader) do
  user_columns :sending_application,
               :sending_facility,
               :receiving_application,
               :receiving_facility,
               :message_date,
               :message_type,
               :message_control_identifier,
               :patient, {:show_view => [:name, { :fields => [:given_name, :family_name], :separator => " " }],
                          :edit_view => [:select, { :fields => [:given_name, :family_name], :separator => " " }, ]}
end