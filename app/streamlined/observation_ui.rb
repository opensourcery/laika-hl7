module ObservationAdditions

end
Observation.class_eval { include ObservationAdditions }

Streamlined.ui_for(Observation) do
  user_columns :value_type,
               :identifier,
               :identifier_text,
               :identifier_code_system,
               :observation_value,
               :units,
               :reference_range,
               :abnormal_flags,
               :patient, {:show_view => [:name, { :fields => [:given_name, :family_name], :separator => " " },
                                        ],
                          :edit_view => [:select]}
               
end