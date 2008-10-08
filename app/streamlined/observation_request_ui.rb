module ObservationRequestAdditions

end
ObservationRequest.class_eval { include ObservationRequestAdditions }

Streamlined.ui_for(ObservationRequest) do
  user_columns :loinc_lab_code, {:show_view => [:name, 
                                                {:fields => [:description], 
                                                 :separator => " "
                                                },
                                               ],
                                 :edit_view => [:select]},
               :ordering_provider,
               :patient, {:show_view => [:name, { :fields => [:given_name, :family_name], :separator => " " }, ],
                          :edit_view => [:select, { :fields => [:given_name, :family_name], :separator => " " }, ]}
               
end