class ProfileController < ApplicationController
  # Use the pd_user layout (i.e., views/layout/pd_user.html.erb)
  layout "pd_user"
  
  ########################
  #      I N D E X       #
  ########################
  def index
    @title = "Profiles"
  end

  ######################
  #      S H O W       #
  ######################
  def show
    @hide_edit_links = true
    login_name = params[:login_name]
    @pd_user = PdUser.find_by_login_name(login_name)
    
    if (@pd_user != nil)
      @title = "Profile for #{login_name}"
      @spec = @pd_user.spec ||= Spec.new
      @personal_life = @pd_user.personal_life ||= PersonalLife.new
      @professional_life = @pd_user.professional_life ||= ProfessionalLife.new
    else
      flash[:warning] = "No user #{login_name} is registered."
      redirect_to :action => "index"
    end
  end  
end