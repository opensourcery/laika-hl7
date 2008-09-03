class ValidationError < ActiveRecord::Base
  belongs_to :received_message
end
