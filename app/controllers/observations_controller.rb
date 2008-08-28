class ObservationsController < ApplicationController
  layout 'streamlined'
  acts_as_streamlined
  streamlined_ui 'Observation'
end