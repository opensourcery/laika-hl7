require File.dirname(__FILE__) + '/../test_helper'

class ObservationTest < ActiveSupport::TestCase
  context 'A Observation Instance' do
    setup do 
      @patient = Patient.find_by_identifier('00000111^^^^AN')
      @observation = @patient.observations.first
    end
    
    should 'generate a hl7 v2.5.1 OBX segment' do
      obx_segment = @observation.to_obx
      assert(obx_segment)
      assert_equal('CE', obx_segment.value_type)
      assert_equal('2341-6^GLUCOSE^LN', obx_segment.observation_id)
      assert_equal('91', obx_segment.observation_value)
      assert_equal('mg/dL', obx_segment.units)
    end
    
    should 'validate a hl7 v2.5.1 OBX segment' do
      obx_segment = @observation.to_obx
      error_list = @observation.validate_obx_segment(obx_segment)
      assert(error_list)
      assert(error_list.empty?)
    end
    
    should 'fail a hl7 v2.5.1 OBX segment with bad data' do
      obx_segment = @observation.to_obx
      obx_segment.units = 'gallons'
      error_list = @observation.validate_obx_segment(obx_segment)
      assert(error_list)
      error = error_list.first
      assert(error)
      assert_equal('OBX-6', error.location)
    end
  end
end
