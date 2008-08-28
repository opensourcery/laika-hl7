class MessageHeadersController < ApplicationController
  layout 'streamlined'
  acts_as_streamlined
  streamlined_ui 'MessageHeader'
end