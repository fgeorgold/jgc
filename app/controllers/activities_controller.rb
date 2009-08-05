require 'rubygems'
require 'hpricot'
require 'net/http'
require 'uri'
require 'set'


class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.find(:all)
    @title_description = "Activities"
    # Browse activities by categories
    @categories = Set.new
    @programs = Set.new
    @agegroups = Set.new
    for my_activity in @activities do
        @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",my_activity.id];
        for currentProgram in @program_id
          if currentProgram.program_name.empty?
          else
            @programs.add(currentProgram.program_name)  
          end
          
      end
      
       
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.xml
  def show

    @id = params[:id]
    @title_description = "Show Activity"
    @activity = Activity.find(@id) 
    
    @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
    @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
    @comment_id = Activities_Comment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
    @programNames = []
    @categoryNames = []
    @comments = []
    for comment in @comment_id
      @comments.push comment
    end
    
    for currentProgram in @program_id
         @programNames.push currentProgram.program_name
    end

    for currentCategory in @category_id
         @categoryNames.push currentCategory.category_name
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
    

    
  end
  
  
  def save_activity_comment
    @activity_comment = Activities_Comment.new(params[:comment])
    @id = params[:comment][:activity_id]
    @activity = Activity.find(@id)
    @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
    @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
    @comment_id = Activities_Comment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
    @programNames = []
    @categoryNames = []
    @comments = []
    for comment in @comment_id
      @comments.push comment
    end
    
    for currentProgram in @program_id
         @programNames.push currentProgram.program_name
    end

    for currentCategory in @category_id
         @categoryNames.push currentCategory.category_name
    end
    respond_to do |format|
      if @activity_comment.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(@activity) }
        if(@activity.created_by != "No Name" && !@activity.created_by.empty?) 
          pduser = PdUser.find_by_login_name(@activity.created_by)
          subject = "New Comment has been posted for your activity"
          to = pduser.email
          from = 'helpjgc@gmail.com'
          mail = 'A new comment has been posted by  '+ @activity_comment.email + ' for your activity:  '+ @activity.name
          email = Emails.new
          email.from = from
          email.to = to
          email.mail = mail
          email.subject = subject
          email.save
        end		
      else
        format.html { render :action => "show" } 
      end
    end
      
  end
  
  def delete_activity_comment
    @id = params[:activityId]
    @activity = Activity.find(@id)
    @commentId = params[:commentId]
    @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
    @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
    @comment_id = Activities_Comment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
    @programNames = []
    @categoryNames = []
    @comments = []
    for comment in @comment_id
      @comments.push comment.comment_text
    end
    
    for currentProgram in @program_id
         @programNames.push currentProgram.program_name
    end

    for currentCategory in @category_id
         @categoryNames.push currentCategory.category_name
    end
    Activities_Comment.find_by_sql ["DELETE FROM activities_comments where activity_id = ? and id = ?",@id,@commentId]
    redirect_to(@activity)
    
  end
  
  def showActivity
    
    idOrg = params[:activity][:id]
    @activity = Activity.find(idOrg)
    @title_description = @activity.name
  end


  def addActivityAsFavorite
    @favorite = Activities_Favorite.new(:Pduser_id =>params[:Pduser_id],:activitiy_id=>params[:activitiy_id])
    if @favorite.save
      redirect_to :action => 'index', :controller => 'pd_user'
    end
  end

    
  def showActivitiesByPrograms
    @program = params[:program]
    @program_id = Category.find_by_sql ["SELECT * FROM programs where program_name = ?",@program]
   
    @activities = []
    for program in @program_id
      activity = Activity.find(program.activity_id)
      @activities.push activity 
    end
  end
  
  # GET /activities/new
  # GET /activities/new.xml
  def new
    @title_description = "New Activity"
    if(session[:pd_user_id])
      @pdUser =  PdUser.find(session[:pd_user_id]) 
    end
    @activity = Activity.new
    1.times { @activity.programs.build }
    1.times { @activity.categories.build }
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.xml
  def create
    @activity = Activity.new(params[:activity])
    
    suffix = "&parse_address=1"
    base = "http://rpc.geocoder.us/service/namedcsv?address="
    address = @activity.address
    address = address.gsub(/ /, '+')
    webAddress = base << address << suffix
    output = Net::HTTP.get(URI.parse(webAddress))
    
    lat_ss = "lat="
    long_ss = "long="
    
    latIndex = output.index(lat_ss)
    lat = output[latIndex + lat_ss.length, 9]
    
    longIndex = output.index(long_ss)
    long = output[longIndex + long_ss.length, 9]
    
    @activity.lat = lat
    @activity.lon = long   
    
    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(@activity) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
        @u = User.find_by_sql ["SELECT * FROM users where activitesadmin = ?","1"];

        if @u[0].mailpref    
          subject = "New Activity has been created"
          to = @u[0].email
          from = 'helpjgc@gmail.com'
          mail = 'A new Activity '+ @activity.name+' has been created .Kindly review  the Activity.'
          email = Emails.new
          email.from = from
          email.to = to
          email.mail = mail
          email.subject = subject
          email.save
        end	
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to(@activity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(activities_url) }
      format.xml  { head :ok }
    end
  end
end
