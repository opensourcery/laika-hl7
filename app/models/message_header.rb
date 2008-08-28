class MessageHeader < ActiveRecord::Base
  belongs_to :patient
  
  def to_msh
    msh = HL7::Message::Segment::MSH.new
    msh.enc_chars = '^~\&'
    msh.sending_app = self.sending_application
    msh.sending_facility = self.sending_facility
    msh.recv_app = self.receiving_application
    msh.recv_facility = self.receiving_facility
    msh.time = self.message_date.to_formatted_s(:hl7_ts)
    msh.processing_id = rand(10000).to_s
    msh.message_type = self.message_type
    msh.message_control_id = self.message_control_identifier
    msh.version_id = '2.5.1'
    
    msh
  end
end
