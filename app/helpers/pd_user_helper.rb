module PdUserHelper
  
  # Pass as arguments:
  # 1) the text that will be displayed on screen to represent the link
  # 2) the controller
  # 3) the action which is is a Ruby optional argument, with (in our case)
  #    default "index". In other words, if we call nav link with only two
  #    arguments,Ruby knows to make the action variable "index" automatically
  #
  # Return a link for use in layout navigation.
  def nav_link(text, controller, action="index")
    return link_to_unless_current(text, {:controller => controller,
                                         :action => action} )
  end

  # Pass as arguments:
  # 1) the text that will be displayed on screen to represent the link
  # 2) the controller
  #
  # Return a link for use in layout navigation.
  def nav_link_controller(text, controller)
    return link_to_unless_current(text, {:controller => controller})
  end
  
  # Pass as arguments:
  # 1) the text that will be displayed on screen to represent the link
  # 2) the action
  #
  # Return a link for use in layout navigation.
  def nav_link_action(text, action)
    return link_to_unless_current(text, { :action => action})
  end
  
end 