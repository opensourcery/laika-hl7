require File.dirname(__FILE__) + '/../test_helper'

class PatientTest < ActiveSupport::TestCase
  context 'A Patient Instance' do
    setup do 
      @patient = Patient.find_by_identifier('00000111^^^^AN')
    end
    
    should 'generate a hl7 v2.5.1 message' do
      message = @patient.to_message
      assert(message)
      assert_equal('00000111^^^^AN', message[:PID].patient_id_list)
      assert_equal('Thompson^Jennifer', message[:PID].patient_name)
      assert_equal('19770410', message[:PID].patient_dob)
      assert_equal('F', message[:PID].admin_sex)
      assert_equal("2300 Commonwealth Avenue^^Brighton^MA^02135", message[:PID].address)
    end
    
    should 'validate a hl7 v2.5.1 message' do
      message = @patient.to_message
      assert(message)
      error_list = @patient.validate_message(message)
      assert(error_list)
      assert(error_list.empty?)
    end
    
    should 'validate a hl7 v2.5.1 PID segment' do
      message = @patient.to_message
      assert(message)
      error_list = @patient.validate_pid_segment(message[:PID])
      assert(error_list)
      assert(error_list.empty?)
    end
    
    should 'fail a hl7 v2.5.1 PID segment with bad data' do
      message = @patient.to_message
      assert(message)
      message[:PID].admin_sex = 'M'
      error_list = @patient.validate_pid_segment(message[:PID])
      assert(error_list)
      error = error_list.first
      assert(error)
      assert_equal('PID-8', error.location)
    end
  end
end
