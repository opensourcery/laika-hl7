class Observation < ActiveRecord::Base
  
  belongs_to :code_system
  belongs_to :loinc_lab_code
  belongs_to :patient
  
  include ValidationHelper
  
  def to_obx
    obx = HL7::Message::Segment::OBX.new 
    obx.value_type = self.value_type
    obx.observation_id = self.observation_id_field
    obx.observation_value = self.observation_value
    obx.units = self.units
    obx.references_range = self.reference_range
    
    obx
  end
  
  def observation_id_field
    "#{self.loinc_lab_code.code}^#{self.loinc_lab_code.name}^#{self.code_system.code}"
  end
  
  def validate_obx_segment(obx_segment)
    error_list = []
    
    validate_field(self.value_type, obx_segment.value_type, 'OBX-2', error_list)
    validate_field(self.observation_id_field, obx_segment.observation_id, 'OBX-3', error_list)
    validate_field(self.observation_value, obx_segment.observation_value, 'OBX-5', error_list)
    validate_field(self.units, obx_segment.units, 'OBX-6', error_list)
    validate_field(self.reference_range, obx_segment.references_range, 'OBX-7', error_list)
    
    error_list
  end
  
  def get_matching_obx_segment(obx)
    case(obx)
    when(Array)
      obx.each do |individual_obx|
        if individual_obx.observation_id.eql?(self.observation_id_field)
          return individual_obx
        end
      end
    when(HL7::Message::Segment::OBX)
      if obx.observation_id.eql?(self.observation_id_field)
        return obx
      end
    else
      raise ArgumentError
    end
    
    # No match found
    return nil
  end
end
