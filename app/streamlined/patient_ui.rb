module PatientAdditions
  def mirth
    "<a href=\"/patients/send_to_mirth/#{self.id}\">Send to Mirth</a>"
  end
  
  def observation_code_name 
    self.observations.map {|obs| obs.loinc_lab_code.name}.join("\n")
  end
  
  def header_display_name 
    if self.message_header
      return self.message_header.sending_application + " " + self.message_header.sending_facility
    end
    return ""
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
        ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennessee', 'TN'],            ['Texas', 'TX'],                ['Utah', 'UT'],
        ['Virginia', 'VA'],       ['Vermont', 'VT'],      ['Washington', 'WA'],           ['Wisconsin', 'WI'],            ['West Virginia ', 'WV'],
        ['Wyoming', 'WY']]
end


Streamlined.ui_for(Patient) do
  user_columns  :identifier,
                :given_name, 
                :family_name,
                :administrative_sex,  {:enumeration => GenderType::GENDERS},
                :street_address,
                :city,
                :state, {:enumeration => StateType::US},
                :postal_code,
                :country,
                :home_phone,
                :business_phone,
                :observation_code_name,
                :header_display_name,
                :mirth, {:allow_html => true}
end