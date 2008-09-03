require File.dirname(__FILE__) + '/../test_helper'

class MessageHeaderTest < ActiveSupport::TestCase
  context 'A Message Header Instance' do
    setup do 
      @patient = Patient.find_by_identifier('00000111^^^^AN')
      @message_header = @patient.message_header
    end
    
    should 'generate a hl7 v2.5.1 MSH segment' do
      msh_segment = @message_header.to_msh
      assert(msh_segment)
      assert_equal('^Laika_HL7_251^L-CL', msh_segment.sending_app)
      assert_equal('^CCHIT^L-CL', msh_segment.sending_facility)
      assert_equal('Receiving App', msh_segment.recv_app)
      assert_equal('Receiving Facility', msh_segment.recv_facility)
    end
    
    should 'validate a hl7 v2.5.1 MSH segment' do
      msh_segment = @message_header.to_msh
      error_list = @message_header.validate_msh_segment(msh_segment)
      assert(error_list)
      assert(error_list.empty?)
    end
    
    should 'fail a hl7 v2.5.1 MSH segment with bad data' do
      msh_segment = @message_header.to_msh
      msh_segment.sending_app = 'Bad Tool'
      error_list = @message_header.validate_msh_segment(msh_segment)
      assert(error_list)
      error = error_list.first
      assert(error)
      assert_equal('MSH-3', error.location)
    end
  end
end
