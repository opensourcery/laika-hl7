require File.dirname(__FILE__) + '/../test_helper'

class PatientTest < ActiveSupport::TestCase
  context 'A Patient Instance' do
    setup do 
      @patient = Patient.find_by_identifier('00000111^^^^AN')
    end
    
    should 'generate a hl7 v2.5.1 message' do
      message = @patient.to_message
      assert(message)
      assert_equal('Thompson^Jennifer', message[:PID].patient_name)
    end
  end
end
