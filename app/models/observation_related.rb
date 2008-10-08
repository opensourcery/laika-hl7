module ObservationRelated
  def self.included(base)
    base.class_eval do
      belongs_to :loinc_lab_code
      belongs_to :patient

      include ValidationHelper
    end
  end
  
  def observation_id_field
    "#{self.loinc_lab_code.code}^#{self.loinc_lab_code.name}^LN" # Last part hard coded to LOINC
  end
  
  def get_matching_segment(arg, field, klass)
    case(arg)
      when(Array)
        arg.each do |individual_arg|
          if individual_arg.send(field).eql?(self.observation_id_field)
            return individual_arg
          end
        end
      when(klass)
        if arg.send(field).eql?(self.observation_id_field)
          return arg
        end
      else
        raise ArgumentError
    end

    # No match found
    return nil
  end
end