class ProfileController < ApplicationController
  def index
    @title = "Profiles"
  end

  def show
    login_name = params[:login_name]
    @pd_user = PDUser.find_by_login_name(login_name)
    
    if (@pd_user != nil)
      @title = "Profile for #{login_name}"
    else
      flash[:warning] = "No user #{login_name} is registered."
      redirect_to :action => "index"
    end
  end  

end