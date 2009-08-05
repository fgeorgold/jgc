class ProfessionalLifeController < ApplicationController  
  before_filter :protect
  layout 'pd_user' # Instead of having a layout "spec.html.erb" under
                   # app/views/layouts identical to the "pd_user" layout
                   # share the "pd_user" layout
  
  #########################
  #       I N D E X       #
  #########################
  # Used as default action of the SpecController
  def index
    redirect_to pd_user_index_url
  end

  #######################
  #       E D I T       #
  #######################  
  def edit
    @title = "Edit Professional Info"
    @pd_user = PdUser.find(session[:pd_user_id])
        
    # @pd_user.professional_life keeps its current value unless it's nil (i.e., keep current
    # professional_life if there is one). If it is nil, give it is nil create a new professional_life
    @pd_user.professional_life ||= ProfessionalLife.new
    
    @professional_life = @pd_user.professional_life
    
    if (param_posted?(:professional_life))
      if (@pd_user.professional_life.update_attributes(params[:professional_life]))
        flash[:notification] = "Changes saved."
        redirect_to pd_user_index_url
      end
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
      session[:protected_page] = request.request_uri      
      flash[:warning] = "Please log in first"
      redirect_to :controller => "pd_user", :action => "login"
      
      # Rails uses before_filter to build up a chain of filters,
      # executing each one in turn. We will sometimes have more than one
      # function in the chain, and these functions might require a logged-in user;
      # it's therefore important for protect to break the chain if the user isn't
      # logged in. The way to do this is to return false.      
      return false
    end
  end  
end

