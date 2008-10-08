require File.dirname(__FILE__) + '/../test_helper'

class ObservationRequestTest < ActiveSupport::TestCase
  context 'A ObservationRequest Instance' do
    setup do 
      @patient = Patient.find_by_identifier('00000111^^^^AN')
      @observation_request = @patient.observation_requests.first
    end
    
    should 'generate a hl7 v2.5.1 OBR segment' do
      obr_segment = @observation_request.to_obr
      assert(obr_segment)
      assert_equal('785-6^MCH^LN', obr_segment.universal_service_id)
      assert_equal('24601^SIMPSON^NICK^^^DR.', obr_segment.ordering_provider)
    end
    
    should 'validate a hl7 v2.5.1 OBR segment' do
      obr_segment = @observation_request.to_obr
      error_list = @observation_request.validate_obr_segment(obr_segment)
      assert(error_list)
      assert(error_list.empty?)
    end
    
    should 'fail a hl7 v2.5.1 OBR segment with bad data' do
      obr_segment = @observation_request.to_obr
      obr_segment.ordering_provider = 'Dr. Horrible'
      error_list = @observation_request.validate_obr_segment(obr_segment)
      assert(error_list)
      error = error_list.first
      assert(error)
      assert_equal('OBR-16', error.location)
    end
  end
end
