module PatientAdditions
  def mirth
    "<a href=\"/patients/send_to_mirth/#{self.id}\">Send to Mirth</a>"
  end
end

Patient.class_eval { include PatientAdditions }

class GenderType
  GENDERS = [['Male', 'M'], ['Female', 'F']]
end

class StateType
  US = [['Alaska', 'AK'],         ['Alabama', 'AL'],      ['Arkansas', 'AR'],             ['Arizona', 'AZ'],              ['California', 'CA'],
        ['Colorado', 'CO'],       ['Connecticut', 'CT'],  ['District of Columbia', 'DC'], ['Delaware', 'DE'],             ['Florida', 'FL'],
        ['Georgia', 'GA'],        ['Hawaii', 'HI'],       ['Iowa', 'IA'],                 ['Idaho', 'ID'],                ['Illinois', 'IL'],
        ['Indiana', 'IN'],        ['Kansas', 'KS'],       ['Kentucky', 'KY'],             ['Louisiana', 'LA'],            ['Massachusetts', 'MA'],
        ['Maryland', 'MD'],       ['Maine', 'ME'],        ['Michigan', 'MI'],             ['Minnesota', 'MN'],            ['Missouri', 'MO'],
        ['Mississippi', 'MS'],    ['Montana', 'MT'],      ['North Carolina', 'NC'],       ['North Dakota', 'ND'],         ['Nebraska', 'NE'],
        ['New Hampshire', 'NH'],  ['New Jersey', 'NJ'],   ['New Mexico', 'NM'],           ['Nevada', 'NV'],               ['New York', 'NY'],
        ['Ohio', 'OH'],           ['Oklahoma', 'OK'],     ['Oregon', 'OR'],               ['Pennsylvania', 'PA'],         ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennesse', 'TN'],             ['Texas', 'TX'],                ['Utah', 'UT'],
        ['Virginia', 'VA'],       ['Vermont', 'VT'],      ['Washington', 'WA'],           ['Wisconson', 'WI'],            ['West Virginia ', 'WV'],
        ['Wyoming', 'WY']]
end

Streamlined.ui_for(Patient) do
  user_columns  :given_name, 
                :family_name,
                :administrative_sex,  {:enumeration => GenderType::GENDERS},
                :street_address,
                :city,
                :state, {:enumeration => StateType::US},
                :postal_code,
                :country,
                :home_phone,
                :business_phone,
                :observations, {:show_view => [:list, 
                                               {:fields => [:observation_value, :units]}
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