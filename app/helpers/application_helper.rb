# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def streamlined_side_menus
    [ 
      ["Patients", {:controller => "patients"}],
      ["Observations", {:controller => "observations"}],
      ["Message Headers", {:controller => "message_headers"}],
      ["Received Messages", {:controller => "received_messages"}]
    ]
  end
  
  def streamlined_top_menus
    [ 
      ["HL7 Message Testing", '/'] 
    ]
  end
  
end
