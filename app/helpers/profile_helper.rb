module ProfileHelper
  
  #####################################
  #       P R O F I L E _ F O R       #
  #####################################
  # Return the user's profile URL.
  def profile_for(user)
    profile_url(:login_name => user.login_name)
  end
  
  #############################################
  #       H I D E _ E D I T _ L I N K S       #
  #############################################
  # Return true if hiding the edit links for spec,
  # personal life, professional life etc.
  def hide_edit_links?
    # instance variables are nil if not defined,
    # so the function returns false unless @hide_edit_links
    # is set explicitly
    return (@hide_edit_links != nil)
  end
end
