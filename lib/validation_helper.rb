module ValidationHelper
  def validate_field(expected_value, actual_value, segment_field, error_list)
    unless expected_value.blank?
      if actual_value.blank?
        error_list << ValidationError.new(:location => segment_field, :message => "Expected #{expected_value}, but was blank")
      else
        unless expected_value.eql?(actual_value)
          error_list << ValidationError.new(:location => segment_field, :message => "Expected #{expected_value}, but got #{actual_value}")
        end
      end
    end
  end
end