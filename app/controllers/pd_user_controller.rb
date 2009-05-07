class PdUserController < ApplicationController
  #layout "program_director"
  
  def index
  end

  def register
    @title_description = "Registration Form"
    @title = "Program Director Registration"
    
    if ((request.post?) and (params[:pd_user] != nil))
      @pd_user = PDUser.new(params[:pd_user])
      
      # Inspect the variable -- raise an exception to stop the execution
      # and dumpt the the contents to the browser screen
      # It�s a heavy-handed debugging approach, but sometimes that's
      # exactly what the situation calls for. 
      #raise params[:pd_user].inspect      
      # Output goes to log file (logs/development.log in development mode)
      logger.info params[:pd_user].inspect

      if @pd_user.save
        flash[:notice] = "User #{@pd_user.screen_name} registered successfully!"
        #redirect_to :controller => "profiles", :action => "new" 
      end
    end    
  end

end
