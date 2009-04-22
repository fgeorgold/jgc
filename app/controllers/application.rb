# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '63104ae65393c69e0cdc5b937edbf46d'
  
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
    flash[:message] ='This is a test'
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
      if(session[:user] && session[:user].admin && session[:user].affiliateOrg)
         redirect_to :controller=>'user', :action=> 'welcomeAdminUser'
      end
      if(session[:user] && session[:user].admin && !session[:user].affiliateOrg)
        redirect_to :controller=>'user', :action=> 'welcomeUser'    
      end
      if(session[:user] && !session[:user].admin && session[:user].affiliateOrg)
         redirect_to :controller=>'user', :action=> 'welcomeOrgUser'
      end
      if(session[:user] && !session[:user].admin && !session[:user].affiliateOrg)
         redirect_to :controller=>'user', :action=> 'welcomeUser'
      end
      
    end
  end
  
  

end


