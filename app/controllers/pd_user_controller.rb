class PdUserController < ApplicationController

  before_filter :protect, :only => [:show_basic_info, :edit]
  
  ###############################
  #       R E G I S T E R       #
  ###############################
  def register
    @title_description = "Register"
    @title = "Program Director Registration"
    
    if (param_posted?(:pd_user))
      @pd_user = PDUser.new(params[:pd_user])
      
      # Inspect the variable -- raise an exception to stop the execution
      # and dumpt the the contents to the browser screen
      # It's a heavy-handed debugging approach, but sometimes that's
      # exactly what the situation calls for. 
      #raise params[:pd_user].inspect      
      # Output goes to log file (logs/development.log in development mode)
      logger.info params[:pd_user].inspect

      if @pd_user.save
        session[:pd_user_id] = @pd_user.id
        flash[:notification] = "User #{@pd_user.login_name} registered successfully!"
        @u = User.find_by_sql ["SELECT * FROM users where admin = ?","1"];
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
        redirect_to :action => "show_basic_info"
      end
    end    
  end
  
  ###########################
  #       L O G   I N       #
  ###########################
  def login
    @title_description = "Log in"
    @title = "Log in to Profile"
    
    if (param_posted?(:pd_user))
      @pd_user = PDUser.new(params[:pd_user])

      # Search in the registered users for the user based on its screen name
      # and password
      pd_user = PDUser.find_by_login_name_and_password(@pd_user.login_name,
                                                       @pd_user.password)
                                                        
      if (pd_user != nil)
        # Login successful
        session[:pd_user_id] = pd_user.id
        flash[:notification] = "User #{pd_user.login_name} logged in!"
        redirect_to :action => "show_basic_info"
      else
        # Login failed
        # Don't show the password in the view
        @pd_user.password = nil
        flash[:error] = "Invalid login name or password"
      end
    end    
  end
  
  #############################
  #       L O G   O U T       #
  #############################
  def logout
    session[:pd_user_id] = nil
    flash[:notification] = "Logged out"
    redirect_to :action => "login"
  end
  
  #############################################
  #       S H O W   B A S I C   I N F O       #
  #############################################
  # Edit the user's basic info
  def show_basic_info
    @title_description = "Basic Info"
    @title = "Basic Information"
    @pd_user = PDUser.find(session[:pd_user_id])    
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
      if @pd_user.update_attributes(params[:pd_user])
        flash[:notification] = "Email updated"
        redirect_to :action => "show_basic_info"
      end
    end
    
    # For security purposes, never fill in password fields.
   @pd_user.clear_password!    
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
    if (session[:pd_user_id] == nil)
      flash[:warning] = "Please log in first"
      redirect_to :action => "login"
      return false
    end
  end
  
  #######################################
  #       P A R A M _ P O S T E D       #
  #######################################
  # Return true if a parameter corresponding
  #  to the given symbol was posted.
  def param_posted?(symbol)
    (request.post?) and (params[symbol] != nil)
  end
  
end