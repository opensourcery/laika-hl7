module ObservationAdditions

end
Observation.class_eval { include ObservationAdditions }

Streamlined.ui_for(Observation) do
  user_columns :value_type,
               :identifier_code_system,
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
               :patient, {:show_view => [:name, { :fields => [:given_name, :family_name], :separator => " " },
                                        ],
                          :edit_view => [:select]}
               
end