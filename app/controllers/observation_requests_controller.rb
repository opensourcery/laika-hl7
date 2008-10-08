class ObservationRequestsController < ApplicationController
  layout 'streamlined'
  acts_as_streamlined
  streamlined_ui 'ObservationRequest'
end