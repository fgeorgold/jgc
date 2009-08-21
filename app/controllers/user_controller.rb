
require 'fastercsv'

class UserController < ApplicationController

  before_filter :login_required, :only=>['welcome','change_password']

    def RemovePartner
    @idOrg = params[:orgId]
    @row = params[:rowid]
    Partner.delete(@row)
    #@row_id = []
    #@row_id = Partner.find_by_sql ["SELECT * FROM partners WHERE organization_id =? and partner_org_id =?",@idOrg,@partnerId]
    #for row_id in @row_id
      #Partner.delete(row_id)
    #end
    redirect_to :action => 'show', :controller => 'organizations',:id => @idOrg
    
    end

    def RemoveASP
    @idOrg = params[:orgId]
    @row = params[:rowid]
    Asp.delete(@row)
    #@row_id = []
    #@row_id = Partner.find_by_sql ["SELECT * FROM partners WHERE organization_id =? and partner_org_id =?",@idOrg,@partnerId]
    #for row_id in @row_id
      #Partner.delete(row_id)
    #end
    redirect_to :action => 'show', :controller => 'organizations',:id => @idOrg
      
    end
 
  def organizationSearch
    case params[:submit]
      when "Find Near Me!"
        redirect_to :action => "findByLocation", :input => params[:input], :address => params[:address]
        return
      when "Search"
        redirect_to :action => "searchResults", :input => params[:input], :text => params[:text]
        return
    end      
  end
  
  def findByLocation
    @user = session[:user]
    @openingText = ""
    if(@user == nil)
      @openingText = "Hello, it looks like you are not a registered user.  To find an organization near you, please enter your zipcode below, or just select an orgnization using our index."
		end
    
    @alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    allorganizations = Organization.find(:all)
    # Commenting out search
    # @posts = Organization.find_by_contents("american")
    @organizations = []

    for organization in allorganizations do
        if(organization.visible == true)
          @organizations.push organization
        end
    end
    @organizations.sort! { |x,y| x.name.downcase <=> y.name.downcase }
    
  	@AlphabeticalList = Organization.find(:all).to_set.classify {
    |organization| organization.name[0].chr}
    
    #Can't sort set???

    @hDisplay = true
    @orgUser = true
    @title_description = "Organizations Search Results by Location"
    @query = params[:input][:address]
    
    zip = Zip.new
    zip = zip.get_zipcode(@query)
    @nearbyOrganizations = zip.find_nearby_organizations
  end
  
  def searchResults
    @hDisplay = true
    @orgUser = true
    @title_description = "Organizations Search Results"
    @query = params[:input][:text]
    # Commenting out Organizations free text search
    #@posts = Organization.find_by_contents(@query) 
    @results = Organization.find_with_ferret(@query)
    
    @results.sort! { |x,y| x.ferret_score <=> y.ferret_score }
  end

  def browseOrganizations
    @alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    allorganizations = Organization.find(:all)
    @organizations = []
    for organization in allorganizations do
        if(organization.visible == true)
          @organizations.push organization
        end
    end
    @organizations.sort! { |x,y| x.name.downcase <=> y.name.downcase }
    
  	@AlphabeticalList = Organization.find(:all).to_set.classify {
    |organization| organization.name[0].chr}
  end
  

  def BrowseByPrograms
    @title_description = "Activities Search - Browse By Programs"
    @orgUser = false
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
 
 def BrowseAllActivities
   @title_description = "Activities Search - All"
   @orgUser = false
   @activities = Activity.find(:all)
   
 end

  def BrowseByCategories
    @orgUser = false
    @title_description = "Activities Search - Browse by Categories"
  end
  
  def BrowseByAgeGroups
    @orgUser = false
    @title_description = "Activities Search - Browse by Age Groups"
  end

 def showActivitiesByPrograms
    @orgUser = false
    @title_description = "Activities Search - Browse by Programs"
    @program = params[:program]
    @statistic = Statistics.new()
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
   
    @activities = []
    for program in @program_id
      @activity = Activity.find(program.activity_id)
      if(!@activity.cost.empty?)
        @statistic.costs[@activity.cost] += 1
      end
      if(!@activity.age_group.empty?)
        @statistic.age_group[@activity.age_group] += 1
      end
      if(!@activity.duration.empty?)
        @statistic.duration[@activity.duration] += 1
      end
      @activities.push @activity 
    end
  end
  
  def showAllActivities
    activityId = params[:activity][:id]  
    @activity = Activity.find(activityId)
    @title_description= @activity.name
    redirect_to(@activity)
  end
  
  
  
  def showActivitiesByCategory
    @orgUser = false
    @title_description = "Activities Search - Browse by Categories"
    @category = params[:category]
    @statistic = Statistics.new()
    @type = params[:type]
    @category_id = Category.find_by_sql ["SELECT * FROM categories where category_name = ?",@category]
    @activities = []
    for category in @category_id
      @activity = Activity.find(category.activity_id)
      if(!@activity.cost.empty?)
        @statistic.costs[@activity.cost] += 1
      end
      if(!@activity.age_group.empty?)
        @statistic.age_group[@activity.age_group] += 1
      end
      if(!@activity.duration.empty?)
        @statistic.duration[@activity.duration] += 1
      end
      @activities.push @activity 
    end
  end
  
  def showActivitiesByAgeGroup
    @orgUser = false
    @title_description = "Activities Search - Browse by Age Groups"
    @age_group = params[:age_group]
    @statistic = Statistics.new()
    @activity_id = Activity.find_by_sql ["SELECT * FROM activities where age_group = ?",@age_group]
    @activities = []
    for @activity in @activity_id
            if(!@activity.cost.empty?)
        @statistic.costs[@activity.cost] += 1
      end
      if(!@activity.age_group.empty?)
        @statistic.age_group[@activity.age_group] += 1
      end
      if(!@activity.duration.empty?)
        @statistic.duration[@activity.duration] += 1
      end
      @activities.push @activity 
    end
  end
  
  def DurationFilterOnCategory
    @orgUser = false
    @title_description = "Activities Search"
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
    @title_description = "Activities Search"
    @orgUser = false
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
    @title_description = "Activities Search"
    @orgUser = false
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
    @title_description = "Activities Search"
    @orgUser = false
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
    @title_description = "Activities Search"
    @orgUser = false
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
    @orgUser = false
   
    @title_description = "Activities Search"
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
    @orgUser = false
    @title_description = "Activities Search"
    @age = params[:age]
    @duration = params[:duration]
    @activities = Activity.find_by_sql ["SELECT * FROM activities where age_group = ? and duration =?",@age,@duration]
  end
  
  def CostFilterOnAge
    @orgUser = false
    @title_description = "Activities Search"
    @age = params[:age]
    @cost = params[:cost]
    @activities = Activity.find_by_sql ["SELECT * FROM activities where age_group = ? and cost =?",@age,@cost]
  end
  
  def searchActivities
    @hDisplay = false
    @orgUser = false
    @title_description = "Activities Search"
  end
  
  def searchActivityResults
    @hDisplay = false
    @orgUser = false
    @title_description = "Activities Search Results"
    @activityQuery = params[:input][:text]

    @results = Activity.find_with_ferret(@activityQuery)
    @results.sort! { |x,y| x.ferret_score <=> y.ferret_score }

    tags = @activityQuery.split(',')

    for tag in tags

      x = Tag.find(:first, :conditions => {:description => tag} )
      if(x != nil)
        for activity in x.activities
          @results.push activity
        end
      end

    end

  end
  
  def search
    @hDisplay = true
    @orgUser = true
    @title_description = "Organizations Search"
  end
  
  def advancedSearch
    @hDisplay = true
    @orgUser = true
    @title_description = "Advanced Organizations Search"
    @orgUser = true
  end
  
  def advancedSearchResults
    @hDisplay = true
    @orgUser = true
    @title_description = "Advanced Organizations Search Results"
    
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
    resource += '%'
    append ='%'
    append +=resource
    if(resource != "")
      organizations = Organization.find_by_sql ["SELECT * FROM organizations where resources LIKE ?",append];
    end  
    return organizations
  end
  
  # Sample SQL Like query
  # SELECT * FROM organizations WHERE name LIKE 'TES%'
  def searchByName(name)
    organizations = []
    if(name != "")
      name += '%'
      append ='%'
      append +=name
      organizations = Organization.find_by_sql ["SELECT * FROM organizations where name LIKE ?",append];
    end  
    
    return organizations
  end
  
  
  def signup
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - Organizational User Signup"
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
  
  def index
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - Welcome Organizational User"
  end

  def login
    @title_description = "JGC - Welcome Organizational User"
    @hDisplay = true
    @orgUser = true
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to_stored 
      else
        flash[:error] = "Invalid login name or password"
      end
    end
  end
  
  
  def activitiesAdmin
    @hDisplay = false
    @orgUser = false
    @title_description = "JGC - Activities Admin"
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
    @hDisplay = true
    @orgUser = true
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



  def welcomeOrgUser
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - Organizational User"
    @userC = session[:user]
    @organization = Organization.find_by_name(@userC.affiliateOrg)

  
  end

  def welcomeActivitiesAdmin
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - Activities Admin"
   
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
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - Admin"
    @userC = session[:user]
    @allorganizations = Organization.find(:all)
    @allUsers = User.find(:all)
    @organizations = []
    @users = []
    
    for user in @allUsers do
      if(user.edit_perms == false && user.affiliateOrg)
        @users.push user
      end
    end
    
    for organization in @allorganizations do
        if(organization.visible == false)
          @organizations.push organization
        end
    end
      
  end
  

  def welcomeUser
    @hDisplay = true
    @orgUser = true
    @title_description = "JGC - User"
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

  def approveUser
    userId = params[:id]
    @user = User.find(userId)
    @user.update_attribute(:edit_perms,true)
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
  @hDisplay = false
  @orgUser = false
  @title_description = "JGC - Feedback"
end



def SaveComment
  @comment = Comment.new(params[:user])
  if @comment.save
    redirect_to "/index.html"
    @u = User.find_by_sql ["SELECT * FROM users where admin = ?","1"];
    if @u[0].mailpref    
      subject = "New FeedBack has been Posted"
      to = @u[0].email
      from = 'helpjgc@gmail.com'
      mail = "A new Feedback  has been posted by "+ @comment.name + " ("+@comment.email+").Following is the feedback for JGC \n"+@comment.comment_text
      email = Emails.new
      email.from = from
      email.to = to
      email.mail = mail
      email.subject = subject
      email.save
    end	
  else
    render :action => "userComment"
    flash[:notice] = 'Unable to process comment'
  end
end

 def delete_activity_comment
    @id = params[:activityId]
    @activity = Activity.find(@id)
    @commentId = params[:commentId]
    Activities_Comment.delete(@commentId)
    redirect_to(@activity)
    

 end


  
  def edit_profile
  @hDisplay = true
  @orgUser = true
  @title = "Editing profile"
  @user=session[:user]
  if request.post?
 
      if params[:password_button]
           @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        if @user.save 
        flash[:notice]="Password Changed"
        if @user.admin
          redirect_to :action=>'welcomeAdminUser'
        end
        if @user.activitesadmin
        redirect_to :action=>'welcomeActivitiesAdmin'
        else
        if @user.affiliateOrg
        redirect_to :action=>'welcomeOrgUser'
        else
       redirect_to :action=>'welcomeUser'
        end
        end
      end
    else
       # @user = User.find(session[:user])
        @user.update_attribute(:mailpref,params[:mailpref])
        #if @UserC.save 
        flash[:notice]="Mail Preference changed"
        if @user.admin
          redirect_to :action=>'welcomeAdminUser'
        end
        if @user.activitesadmin
        redirect_to :action=>'welcomeActivitiesAdmin'
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
  
  
end




