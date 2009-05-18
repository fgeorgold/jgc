# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery :secret => 'secretpass'#'b584fa482124a769b4209625b2ab6767c40b67fc00d7cd66536ecfc07dc314442320fc05bd7f02f7d5d4c8d2ea36f6271296429d60bd6fbd5610a41099f51fb0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
 def login_required
    if session[:user]
      return true
    end
    flash[:message]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to :controller => "user", :action => "login"
    
    return false 
  end
  
  def user_logged
    if (session[:user])
      return true
    else
      return false
    end
  end

  def current_user
     session[:user]
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to(return_to)
    else
      if(session[:user] && session[:user].activitesadmin)
        redirect_to :controller=>'user', :action=> 'welcomeActivitiesAdmin'
      end
      if(session[:user] && session[:user].admin && session[:user].affiliateOrg)
         redirect_to :controller=>'user', :action=> 'welcomeAdminUser'
      end
      if(session[:user] && session[:user].admin && !session[:user].affiliateOrg)
        redirect_to :controller=>'user', :action=> 'welcomeUser'    
      end
      if(session[:user] && !session[:user].admin && session[:user].affiliateOrg)
         redirect_to :controller=>'user', :action=> 'welcomeOrgUser'
      end
      if(session[:user] && !session[:user].admin && !session[:user].affiliateOrg && !session[:user].activitesadmin)
         redirect_to :controller=>'user', :action=> 'welcomeUser'
      end
      
    end
  end
  
  

end


