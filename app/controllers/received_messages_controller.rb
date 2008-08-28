class ReceivedMessagesController < ApplicationController
  layout 'streamlined'
  acts_as_streamlined
  streamlined_ui 'ReceivedMessage'
  
  protect_from_forgery :except => :inbox
  
  def inbox
    received_message = ReceivedMessage.new
    received_message.message_contents = params[:hl7message]
    received_message.save!
    render :nothing => true
  end
  
  def raw_message
    @received_message = ReceivedMessage.find(params[:id])
  end
end