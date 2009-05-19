
require 'fastercsv'

class UserController < ApplicationController

  before_filter :login_required, :only=>['welcome','change_password']

  def searchResults
    @query = params[:user][:text]
    @posts = Organization.find_by_contents(@query) 
  end
  
  def BrowseByPrograms 
    @activities = Activity.find(:all)
     @programs = Set.new
     for my_activity in @activities do
        @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",my_activity.id];
        for currentProgram in @program_id
          if currentProgram.program_name.empty?
          else
            @programs.add(currentProgram.program_name)  
          end
          
      end
   end
 
end

 def showActivitiesByPrograms
    @program = params[:program]
    @statistic = Statistics.new()
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
   
    @activities = []
    for program in @program_id
      activity = Activity.find(program.activity_id)
      @statistic.costs[activity.cost] =+1
      @statistic.age_group[activity.age_group] =+1
      @statistic.duration[activity.duration] =+1
      @activities.push activity 
    end
  end
  
  def showActivitiesByCategory
    @category = params[:category]
    @statistic = Statistics.new()
    @type = params[:type]
    @category_id = Category.find_by_sql ["SELECT * FROM categories where category_name = ?",@category]
    @activities = []
    for category in @category_id
      activity = Activity.find(category.activity_id)
      @statistic.costs[activity.cost] =+1
      @statistic.age_group[activity.age_group] =+1
      @statistic.duration[activity.duration] =+1
      @activities.push activity 
    end
  end
  
  def DurationFilterOnCategory
    @duration = params[:duration]
    @category = params[:category]
    @activities = []
    @category_id = Category.find_by_sql ["SELECT * FROM categories where category_name = ?",@category]
    for category in @category_id
      activity = Activity.find(category.activity_id)
      if(activity.duration == @duration)
        @activities.push activity 
      end
    end  
  end
  
    def CostFilterOnCategory
    @cost = params[:cost]
    @category = params[:category]
    @activities = []
    @category_id = Category.find_by_sql ["SELECT * FROM categories where category_name = ?",@category]
    for category in @category_id
      activity = Activity.find(category.activity_id)
      if(activity.cost == @cost)
        @activities.push activity 
      end
    end 
    
  end
  
    def AgeFilterOnCategory
    @age = params[:age]
    @category = params[:category]
    @activities = []
    @category_id = Category.find_by_sql ["SELECT * FROM categories where category_name = ?",@category]
    for category in @category_id
      activity = Activity.find(category.activity_id)
      if(activity.age_group == @age)
        @activities.push activity 
      end
    end 
    
  end
  
  def DurationFilterOnProgram
    @program = params[:program]
    @duration = params[:duration]
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
    @activities = []
    for program in @program_id
      activity = Activity.find(program.activity_id)
      if(activity.duration == @duration)
        @activities.push activity 
      end
    end
    
  end

  def CostFilterOnProgram
    @program = params[:program]
    @cost = params[:cost]
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
    @activities = []
    for program in @program_id
      activity = Activity.find(program.activity_id)
      if(activity.cost == @cost)
        @activities.push activity 
      end
    end
  end

  def AgeFilterOnProgram
    @program = params[:program]
    @age = params[:age]
   
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
    @activities = []
    for program in @program_id
      activity = Activity.find(program.activity_id)
      if(activity.age_group == @age)
        @activities.push activity 
      end
    end
    
  end
    
  def DurationFilterOnAge
    
  end
  
  def CostFilterOnAge
    
  end
  
  
  def searchActivityResults
    @activityQuery = params[:user][:text]
    @activityPosts = Activity.find_by_contents(@activityQuery)
    if(!@activityPosts)
      render :layout => "searchActivities"
      end
  end
  
  def advancedSearchResults
    name = params[:user][:name]
    resources = params[:user][:resources]
    asp = params[:user][:asp]
    @organizationsMatchingResources = searchByResources(resources)
    @organizationsMatchingASPs = searchByASP(asp)
    @organizationsMatchingName = searchByName(name)
  end

  def searchByASP(asp)
    organizations = []
    if(asp != "")
     organizations = Organization.find_by_sql ["SELECT * FROM organizations where asp= ?",asp];
   end
   return organizations
  end
  
  def searchByResources(resource)
    organizations = []
    if(resource != "")
      organizations = Organization.find_by_sql ["SELECT * FROM organizations where resources = ?",resource];
    end  
    return organizations
  end

  def searchByName(name)
    organizations = []
    if(name != "")
      organizations = Organization.find_by_sql ["SELECT * FROM organizations where name = ?",name];
    end  
    return organizations
  end
  def add_item1
    render :text => "<li>" + params[:newitem] + "</li>"
  end


  def signup
    @user = User.new(params[:user])
    if request.post?  
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        @userC = session[:user]
        if(@userC && @userC.admin && @userC.affiliateOrg)
          redirect_to :action=> 'welcomeAdminUser'
        end
        if(@userC && @userC.admin && !@userC.affiliateOrg)
          redirect_to :action=> 'welcomeUser'    
        end
        
        if(@userC && !@userC.admin && @userC.affiliateOrg)
          redirect_to :action=> 'welcomeOrgUser'
        end
        if(@userC && !@userC.admin && !@userC.affiliateOrg)
          redirect_to :action=> 'welcomeUser'
        end
        @u = User.find_by_sql ["SELECT * FROM users where admin = ?","1"];
        if @u[0].mailpref
        subject = "New User has joined the network "
        to = @u[0].email
        from = 'helpjgc@gmail.com'
        mail = 'A new User: '+ @userC.login + ' has joined the network.Contact the new user at '+ @userC.email
        email = Emails.new
        email.from = from
        email.to = to
        email.mail = mail
        email.subject = subject
        email.save
      #  Emails.sendMail#deliver_send_mail(to,from,mail,subject)
        end
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to_stored 
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end
  
  
  def activitiesAdmin
     if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        if session[:user].activitesadmin
          flash[:message]  = "Login successful"
          redirect_to :action => 'welcomeActivitiesAdmin'
        else
          flash[:warning] = "Login unsuccessful"
        end
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:notice]="Password Changed"
       if @user.admin
          redirect_to :action=>'welcomeAdminUser'
        else
        if @user.affiliateOrg
        redirect_to :action=>'welcomeOrgUser'
      else
     redirect_to :action=>'welcomeUser'
      end
    end
      end
    end
  end

  def welcomeOrgUser
    @userC = session[:user]
    @organization = Organization.find_by_name(@userC.affiliateOrg)

  
  end

  def welcomeActivitiesAdmin
   @userC =  session[:user]
   allActivities = Activity.find(:all)
   @activities = []
   for activity in allActivities do
       if(activity.visible == false)
          @activities.push activity
       end
    end
  end

  def welcomeAdminUser
    @userC = session[:user]
    @allorganizations = Organization.find(:all)
    @organizations = []
    for organization in @allorganizations do
        if(organization.visible == false)
          @organizations.push organization
        end
    end
      
  end
  

  def welcomeUser
    @userC = session[:user]
    allorganizations = Organization.find(:all)
    @organizations = []
    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.push organization
        end
    end
  end
  
  def addOrg
    idOrg = params[:organization][:id]
    @organization = Organization.find(idOrg)
    session[:user].update_attribute(:affiliateOrg,@organization.name)
    redirect_to_stored
  end
  
  def approveOrg
    idOrg = params[:id]
    @organization = Organization.find(idOrg)
    @organization.update_attribute(:visible,true)
    redirect_to_stored
  end
  
  def approveActivity
    activityID = params[:id]
    @activity = Activity.find(activityID)
    @activity.update_attribute(:visible,true)
    redirect_to_stored
  end

  
def export_to_csv
  @organizations = Organization.find(:all)
  csv_string = FasterCSV.generate do |csv|
    # header row
    csv << ["Name", "WebSite", "Description"]

    # data rows
    @organizations.each do |organization|
      csv << [organization.name, organization.website, organization.description]
    end
  end

  # send it to the browsah
  send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=organizations.csv"
end

def userComment
  @comment = Comment.new(params[:user])
  if @comment.save
    redirect_to "../index.html"
  else
    flash[:notice] = 'Unable to process comment'
    
  end
end


  def change_mail_pref
    @user=session[:user]
  
   #@mailpref = params[:user][:mailpref]
    if request.post?
     @user.update_attributes(:mailpref=>params[:user][:mailpref])
     #User.find_by_sql ["Update users SET mailpref =  where organization_id = ?",@id];
      #if @user.save 
        flash[:notice]="Mail Preference changed"
        if @user.admin
          redirect_to :action=>'welcomeAdminUser'
        else
        if @user.affiliateOrg
        redirect_to :action=>'welcomeOrgUser'
      else
     redirect_to :action=>'welcomeUser'
      end
    end
      #end
   end
  end

end



