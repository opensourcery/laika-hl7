require File.dirname(__FILE__) + '/../test_helper'

class ReceivedMessageTest < ActiveSupport::TestCase
  context 'A Received Message Instance' do
    setup do 
      @good_rm = received_messages(:message_one)
      @bad_rm = received_messages(:message_two)
      @blank_name = received_messages(:blank_name)
      @double_pid = received_messages(:double_pid)
    end
    
    should 'display the patient name' do
      assert_equal('Thompson^Jennifer', @good_rm.name)
    end
    
    should 'state the patient name is blank if none provided' do
      assert_equal('No patient name provided', @blank_name.name)
    end
    
    should 'display the first patient name if more than one PID segment is provided' do
      assert_equal('Thompson^Jenny', @double_pid.name)
    end
    
    should 'display an error when patient name is called on a bad message' do
      assert_equal('Unable to parse message', @bad_rm.name)
    end
    
    should 'validate the message contents' do
      @good_rm.validate_hl7_message
      assert(@good_rm.validation_errors.empty?)
      assert(@good_rm.valid_hl7_message?)
    end
    
    should 'flag a message with bad contents' do
      @bad_rm.validate_hl7_message
      assert(! @bad_rm.validation_errors.empty?)
      assert(! @bad_rm.valid_hl7_message?)
    end
  end
end
