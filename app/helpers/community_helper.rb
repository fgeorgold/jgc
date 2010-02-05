module CommunityHelper
  
  ###############################
  #       N A V _ L I N K       #
  ###############################
  # Pass as arguments:
  # 1) the text that will be displayed on screen to represent the link
  # 2) the controlle
  # 3) the action which is is a Ruby optional argument, with (in our case)
  #    default "index". In other words, if we call nav link with only two
  #    arguments,Ruby knows to make the action variable "index" automatically
  #
  # Return a link for use in layout navigation.
  def nav_link(text, controller, action="index")
    
    # Rails doesn’t know the difference between for e.g. /community/index and
    # /community/index/A => as a result, the Community navigation link
    # won't appear unless we add the :id => nil option.    
    return link_to_unless_current(text, {:id => nil,
                                         :controller => controller,
                                         :action => action} )
  end
  
  ###################################
  #       P A G I N A T E D ?       #
  ###################################
  # Return true if results should be paginated.
  def paginated?
    return ((@pages != nil) and (@pages.length > 1))
  end
end
