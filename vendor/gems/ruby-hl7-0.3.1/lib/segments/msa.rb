# $Id$
require 'ruby-hl7'
class HL7::Message::Segment::MSA < HL7::Message::Segment
  weight 0 # should occur after the msh segment
  add_field :ack_code
  add_field :control_id
  add_field :text
  add_field :expected_seq
  add_field :delayed_ack_type
  add_field :error_cond
end

