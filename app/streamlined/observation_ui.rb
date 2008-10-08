module ObservationAdditions

end
Observation.class_eval { include ObservationAdditions }

class RequestStatus
  VALUES = [['Correction', 'C'], ['Delete', 'D'], ['Final', 'F'], ['Pending', 'I'],
            ['Not asked', 'N'], ['Description Only', 'O'], ['Preliminary', 'P'],
            ['Entered -- not verified', 'R'], ['Partial', 'S'], ['Change status to final for preliminary', 'U'],
            ['Wrong', 'W'], ['Cannot be obtained', 'X']]
end

Streamlined.ui_for(Observation) do
  user_columns :value_type,
               :loinc_lab_code, {:show_view => [:name, 
                                                {:fields => [:description], 
                                                 :separator => " "
                                                },
                                               ],
                                 :edit_view => [:select]},
               :observation_value,
               :units,
               :reference_range,
               :abnormal_flags,
               :result_status, {:enumeration => RequestStatus::VALUES},
               :patient, {:show_view => [:name, { :fields => [:given_name, :family_name], :separator => " " }, ],
                          :edit_view => [:select, { :fields => [:given_name, :family_name], :separator => " " }, ]}
               
end