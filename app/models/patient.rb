class Patient < ActiveRecord::Base
  has_many :observations
  has_one :message_header
  
  def to_message
    msg = HL7::Message.new
    
    msg << message_header.to_msh
    
    pid = HL7::Message::Segment::PID.new 
    pid.patient_id_list = self.identifier
    pid.patient_name = "#{self.family_name}^#{self.given_name}"
    pid.admin_sex = self.administrative_sex
    pid.address = "#{self.street_address}^^#{self.city}^#{self.state}^#{self.postal_code}"
    pid.phone_home = self.home_phone
    pid.phone_business = self.business_phone
    
    msg << pid
    
    observations.each do |observation|
      msg << observation.to_obx
    end
    
    msg
  end
end
