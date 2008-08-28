class Observation < ActiveRecord::Base
  belongs_to :patient
  
  def to_obx
    obx = HL7::Message::Segment::OBX.new 
    obx.value_type = self.value_type
    obx.observation_id = "#{self.identifier}^#{self.identifier_text}^#{self.identifier_code_system}"
    obx.units = self.units
    obx.observation_value = self.observation_value
    obx.references_range = self.reference_range
    
    obx
  end
end
