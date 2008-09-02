require File.dirname(__FILE__) + '/../../test_helper'

class ValidationHelperTest < ActiveSupport::TestCase
  include ValidationHelper
  context 'A Validator' do
    setup do 
      @error_list = []
    end
    
    should 'not return errors when values match' do
      validate_field('foo', 'foo', 'PID-1', @error_list)
      assert(@error_list.empty?)
    end
    
    should 'return an error when values do not match' do
      validate_field('foo', 'bar', 'PID-1', @error_list)
      an_error = @error_list.first
      assert(an_error)
      assert_equal('PID-1', an_error.location)
      assert_equal("Expected foo, but got bar", an_error.message)
    end
    
    should 'return an error when a required value is blank' do
      validate_field('foo', nil, 'PID-1', @error_list)
      an_error = @error_list.first
      assert(an_error)
      assert_equal('PID-1', an_error.location)
      assert_equal("Expected foo, but was blank", an_error.message)
    end
    
    should 'not validate a field when the expected value is blank' do
      validate_field('', 'foo', 'PID-1', @error_list)
      assert(@error_list.empty?)
    end
  end
end