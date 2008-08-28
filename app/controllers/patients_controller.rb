class PatientsController < ApplicationController
  layout 'streamlined'
  acts_as_streamlined
  streamlined_ui 'Patient'
  
  def send_to_mirth
    @patient = Patient.find(params[:id])
    MirthSender.send(@patient.to_message)
  end
end
