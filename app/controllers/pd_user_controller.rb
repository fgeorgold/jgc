class PdUserController < ApplicationController
  include PdUserHelper
  helper :profile # Alternatively: include ProfileHelper
                  # However this would include the helper functions
                  # into both the views and the controller itself
                  # while now the Profile helper functions are
                  # available only in the views
  
  before_filter :protect, :only => [:index, :edit]
  before_filter :check_authorization
  
  ###############################
  #       R E G I S T E R       #
  ###############################
  def register
    @title_description = "Register"
    @title = "Program Director Registration"
    
    if (param_posted?(:pd_user))
      @pd_user = PDUser.new(params[:pd_user])

      if @pd_user.save
        @pd_user.login!(session)
        flash[:notification] = "User #{@pd_user.login_name} registered successfully!"

        @u = User.find_by_sql ["SELECT * FROM users where activitesadmin = ?","1"];
        if @u[0].mailpref
        subject = "New Program Director has joined the network "
        to = @u[0].email
        from = 'helpjgc@gmail.com'
        mail = 'A new Program Director: '+ @pd_user.login_name + ' has joined the network.Contact the new user at '+ @pd_user.email
        email = Emails.new
        email.from = from
        email.to = to
        email.mail = mail
        email.subject = subject
        email.save
        end
        #redirect_to :action => "show_basic_info"

        redirect_to_forwarding_url("index")

      end
    else
      unless (@pd_user.nil?)
        @pd_user.clear_password!
      end
    end      
  end
  
  ###########################
  #       L O G   I N       #
  ###########################
  def login
    @title_description = "Log in"
    @title = "Log in to Profile"
    
    if (request.get?)
      @pd_user = PDUser.new(:remember_me => remember_me_string)
    else
      if (param_posted?(:pd_user))
        @pd_user = PDUser.new(params[:pd_user])

        # Search in the registered users for the user based on its login name
        # and password
        pd_user = PDUser.find_by_login_name_and_password(@pd_user.login_name,
                                                         @pd_user.password)
                                                        
        if (pd_user != nil)
          # Login successful
          pd_user.login!(session)

          # Check whether the box is checked and is so set the remember_me cookie
          if (@pd_user.remember_me?)
            pd_user.remember!(cookies)
          else
            pd_user.forget!(cookies)
          end          
        
          flash[:notification] = "User #{pd_user.login_name} logged in!"        
          redirect_to_forwarding_url("index")
        else
          # Login failed
          # Don't show the password in the view
          @pd_user.clear_password!
          flash[:error] = "Invalid login name or password"
        end
      end    
    end
  end
  
  #############################
  #       L O G   O U T       #
  #############################
  def logout
    PDUser.logout!(session, cookies)    
    flash[:notification] = "Logged out"
    redirect_to :action => "login"
  end

  #########################################################
  ###       C H E C K _ A U T H O R I Z A T I O N       ###
  #########################################################
  # Check for a valid authorization cookie, possibly logging the user in
  def check_authorization
    authorization_token = cookies[:authorization_token]
    if ((authorization_token != nil) && !logged_in?)
      pd_user = PDUser.find_by_authorization_token(authorization_token)
      
      if (pd_user != nil)
        pd_user.login!(session)
      end
    end
  end
  
  ########################
  #      I N D E X       #
  ########################
  # Show the user's info
  def index
    @title_description = "Profile"
    @title = "User Information"
    @pd_user = PDUser.find(session[:pd_user_id])    
    
    # @pd_user.spec keeps its current value unless it's nil (i.e., keep current
    # spec if there is one). If it is nil, give it is nil create a new spec
    @pd_user.spec ||= Spec.new
    @spec = @pd_user.spec
  end
  
  
  #######################
  #       E D I T       #
  #######################
  # Edit the user's basic info
  def edit
    @title_description = "Edit info"
    @title = "Edit basic info"
    @pd_user = PDUser.find(session[:pd_user_id])
    
    if (param_posted?(:pd_user))
      attribute = params[:attribute]
      case attribute
        when "email"
             try_to_update(@pd_user, attribute)
        when "password"
             # Handle password submission.
             if @pd_user.correct_password?(params)
               try_to_update(@pd_user, attribute)
             else
               @pd_user.password_errors(params)
             end 
      end
    end 

    
    # For security purposes, never fill in password fields.
   @pd_user.clear_password!    
  end
  
  ###################################################
  #       P D _ U S E R _ A C T I V I T I E S       #
  ###################################################
  def pd_user_activities
    @title_description = "My Activities"
    @pd_user = PDUser.find(session[:pd_user_id])
    @pd_user_activity = Activity.find_by_sql ["SELECT * FROM activities where created_by = ?", @pd_user.login_name]
  end  
  
  #############################################################
  #############################################################
  ##               H    E    L    P    E    R                ##
  ##        F    U    N    C    T    I    O    N    S        ## 
  #############################################################
  #############################################################
  # All functions that follow will be made private
  # => not accessible for outside objects 
  private 
    
  #############################
  #       P R O T E C T       #
  #############################
  # Protect a page from unauthorized access.
  def protect
    unless (logged_in?)
      # Friendly URL forwarding technique (keep track of request.request_uri)
      session[:protected_page] = request.request_uri      
      flash[:warning] = "Please log in first"
      redirect_to :action => "login"
      
      # Rails uses before_filter to build up a chain of filters,
      # executing each one in turn. We will sometimes have more than one
      # function in the chain, and these functions might require a logged-in user;
      # it’s therefore important for protect to break the chain if the user isn’t
      # logged in. The way to do this is to return false.      
      return false
    end
  end
  
  #######################################
  #       P A R A M _ P O S T E D       #
  #######################################
  # Return true if a parameter corresponding
  #  to the given symbol was posted.
  def param_posted?(symbol)
    return ((request.post?) and (params[symbol] != nil))
  end

  ###################################################################
  #       R E D I R E C T _ T O _ F O R W A R D I N G _ U R L       #
  ###################################################################
  # Instead of redirecting blindly to the "default_action" page
  # redirects to the forwarding URL if not nil. Only if the
  # forwarding URL is nil it redirects to the "default_action" page
  def redirect_to_forwarding_url(default_action)
    redirect_url = session[:protected_page]
    if (redirect_url != nil)
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => default_action
    end    
  end
  
  #########################################
  #       T R Y _ T O _ U P D A T E       #
  #########################################
  # Try to update the pd_user, redirecting if successful.
  def try_to_update(pd_user, attribute)
    if pd_user.update_attributes(params[:pd_user])
      flash[:notification] = "#{attribute} updated."
      redirect_to :action => "index"
    end
  end
  
  ###################################################
  #       R E M E M B E R _ M E _ S T R I N G       #
  ###################################################
  # Return a string with the status of the remember me checkbox.
  def remember_me_string
    return (cookies[:remember_me] || "0")
  end  
end