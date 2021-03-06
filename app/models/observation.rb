class Observation < ActiveRecord::Base
  
  include ObservationRelated
  
  def to_obx
    obx = HL7::Message::Segment::OBX.new 
    obx.value_type = self.value_type
    obx.observation_id = self.observation_id_field
    obx.observation_value = self.observation_value
    obx.units = self.units
    obx.references_range = self.reference_range
    obx.observation_result_status = self.result_status
    
    obx
  end
  
  def validate_obx_segment(obx_segment)
    error_list = []
    
    validate_field(self.value_type, obx_segment.value_type, 'OBX-2', error_list)
    validate_field(self.observation_id_field, obx_segment.observation_id, 'OBX-3', error_list)
    validate_field(self.observation_value, obx_segment.observation_value, 'OBX-5', error_list)
    validate_field(self.units, obx_segment.units, 'OBX-6', error_list)
    validate_field(self.reference_range, obx_segment.references_range, 'OBX-7', error_list)
    validate_field(self.result_status, obx_segment.observation_result_status, 'OBX-11', error_list)
    
    error_list
  end
  
  def get_matching_obx_segment(obx)
    get_matching_segment(obx, :observation_id, HL7::Message::Segment::OBX)
  end
end
