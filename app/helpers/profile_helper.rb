module ProfileHelper
  
  #####################################
  #       P R O F I L E _ F O R       #
  #####################################
  # Return the user's profile URL.
  def profile_for(user)
    profile_url(:login_name => user.login_name)
  end  
end
