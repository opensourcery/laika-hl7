module PatientAdditions
  def mirth
    "<a href=\"/patients/send_to_mirth/#{self.id}\">Send to Mirth</a>"
  end
end
Patient.class_eval { include PatientAdditions }

Streamlined.ui_for(Patient) do
  user_columns  :given_name, :family_name,
                :administrative_sex,
                :street_address,
                :city,
                :state,
                :postal_code,
                :country,
                :home_phone,
                :business_phone,
                :observations, {:show_view => [:list, 
                                               {:fields => [:identifier_text, :observation_value, :units]}
                                              ], 
                                :edit_view => :window},
                :message_header, {:show_view => [:name, 
                                                 {:fields => [:sending_application, :sending_facility], 
                                                  :separator => " "
                                                 },
                                                ],
                                  :edit_view => [:select]},
                :mirth, {:allow_html => true}
                
end