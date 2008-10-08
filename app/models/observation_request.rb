class ObservationRequest < ActiveRecord::Base
  
  include ObservationRelated
  
  def to_obr
    obr = HL7::Message::Segment::OBR.new 
    
    obr.universal_service_id = self.observation_id_field
    obr.ordering_provider = self.ordering_provider
    
    obr
  end
  
  def validate_obr_segment(obr_segment)
    error_list = []
    
    validate_field(self.observation_id_field, obr_segment.universal_service_id, 'OBR-4', error_list)
    validate_field(self.ordering_provider, obr_segment.ordering_provider, 'OBR-16', error_list)
    
    error_list
  end
  
  def get_matching_obr_segment(obr)
    get_matching_segment(obr, :universal_service_id, HL7::Message::Segment::OBR)
  end
end
