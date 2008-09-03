class Patient < ActiveRecord::Base
  has_many :observations
  has_one :message_header
  
  include ValidationHelper
  
  def to_message
    msg = HL7::Message.new
    
    msg << message_header.to_msh
    
    pid = HL7::Message::Segment::PID.new 
    pid.patient_id_list = self.identifier
    pid.patient_name = self.patient_name_field
    pid.patient_dob = self.date_of_birth.to_formatted_s(:hl7_ts)
    pid.admin_sex = self.administrative_sex
    pid.address = self.address_field
    pid.phone_home = self.home_phone
    pid.phone_business = self.business_phone
    
    msg << pid
    
    observations.each do |observation|
      msg << observation.to_obx
    end
    
    msg
  end
  
  def patient_name_field
    "#{self.family_name}^#{self.given_name}"
  end
  
  def address_field
    "#{self.street_address}^^#{self.city}^#{self.state}^#{self.postal_code}"
  end
  
  def validate_message(msg)
    error_list = []
    
    error_list.concat(message_header.validate_msh_segment(msg[:MSH]))
    error_list.concat(validate_pid_segment(msg[:PID]))

    self.observations.each do |observation|
      matching_obx = observation.get_matching_obx_segment(msg[:OBX])
      if matching_obx
        error_list.concat(observation.validate_obx_segment(matching_obx))
      else
        error_list << ValidationError.new(:message => "Unable to find a matching observation for #{observation.identifier_text}")
      end
    end

    error_list
  end
  
  def validate_pid_segment(pid_segment)
    error_list = []
    
    validate_field(self.identifier, pid_segment.patient_id_list, 'PID-3', error_list)
    validate_field(self.patient_name_field, pid_segment.patient_name, 'PID-5', error_list)
    validate_field(self.date_of_birth.to_formatted_s(:hl7_ts), pid_segment.patient_dob, 'PID-7', error_list)
    validate_field(self.administrative_sex, pid_segment.admin_sex, 'PID-8', error_list)
    validate_field(self.address_field, pid_segment.address, 'PID-11', error_list)
    validate_field(self.home_phone, pid_segment.phone_home, 'PID-13', error_list)
    validate_field(self.business_phone, pid_segment.phone_business, 'PID-14', error_list)
    
    error_list
  end
end
