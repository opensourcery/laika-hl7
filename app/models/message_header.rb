class MessageHeader < ActiveRecord::Base
  belongs_to :patient
  
  include ValidationHelper
  
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
  
  def validate_msh_segment(msh_segment)
    error_list = []
    validate_field(self.sending_application, msh_segment.sending_app, 'MSH-3', error_list)
    validate_field(self.sending_facility, msh_segment.sending_facility, 'MSH-4', error_list)
    validate_field(self.receiving_application, msh_segment.recv_app, 'MSH-5', error_list)
    validate_field(self.receiving_facility, msh_segment.recv_facility, 'MSH-6', error_list)
    error_list
  end
end
