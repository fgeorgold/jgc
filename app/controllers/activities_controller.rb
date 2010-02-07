require 'rubygems'
require 'uri'
require 'set'


class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.find(:all)
    @title_description = "Activities"
    # Browse activities by categories
#   @categories = Set.new
#   @programs = Set.new
#   @agegroups = Set.new
#   for my_activity in @activities do
#       @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",my_activity.id];
#       for currentProgram in @program_id
#         if currentProgram.program_name.empty?
#         else
#           @programs.add(currentProgram.program_name)  
#         end
#         
#     end
#     
#      
#   end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

def addActivityToCalendar
  client = GData::Client::Calendar.new
  client.clientlogin('jgccalendar@gmail.com', 'jgcadmin')
  @person = "Jeff"

  # Return documents the authenticated user owns
  feed = client.get('http://www.google.com/calendar/feeds/default/allcalendars/full').to_xml
  entry = feed.elements['entry']  # first <atom:entry>

  acl_entry = <<-EOF
  <entry xmlns='http://www.w3.org/2005/Atom'
      xmlns:gd='http://schemas.google.com/g/2005'>
    <category scheme='http://schemas.google.com/g/2005#kind'
      term='http://schemas.google.com/g/2005#event'></category>
    <title type='text'>Tennis with Jeff</title>
    <content type='text'>Meet for a quick lesson.</content>
    <gd:transparency
      value='http://schemas.google.com/g/2005#event.opaque'>
    </gd:transparency>
    <gd:eventStatus
      value='http://schemas.google.com/g/2005#event.confirmed'>
    </gd:eventStatus>
    <gd:where valueString='Rolling Lawn Courts'></gd:where>
    <gd:when startTime='2009-04-17T15:00:00.000Z'
      endTime='2009-04-17T17:00:00.000Z'></gd:when>
  </entry>
  EOF

  response = client.post("http://www.google.com/calendar/feeds/default/private/full", acl_entry)
end

  # GET /activities/1
  # GET /activities/1.xml
  def show

    @title_description = "Show Activity"
    @activity = Activity.find(params[:id]) 
    
#    @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
#   @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
#   @comment_id = ActivitiesComment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
#   @programNames = []
#   @categoryNames = []
    @comments = @activity.activities_comments
    @new_comment = ActivitiesComment.new
#   for comment in @comment_id
#     @comments.push comment
#   end
#   
#   for currentProgram in @program_id
#        @programNames.push currentProgram.program_name
#   end
#
#   for currentCategory in @category_id
#        @categoryNames.push currentCategory.category_name
#   end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
    

    
  end
  
  
  def save_activity_comment
    @activity_comment = ActivitiesComment.new(params[:new_comment])
    @id = params[:new_comment][:activity_id]
    @activity = Activity.find(@id)
#   @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
#   @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
#   @comment_id = ActivitiesComment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
#   @programNames = []
#   @categoryNames = []
#   @comments = []
#   for comment in @comment_id
#     @comments.push comment
#   end
#   
#   for currentProgram in @program_id
#        @programNames.push currentProgram.program_name
#   end
#
#   for currentCategory in @category_id
#        @categoryNames.push currentCategory.category_name
#   end
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
    @comment_id = ActivitiesComment.find_by_sql ["SELECT * FROM activities_comments where activity_id = ?",@id]
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
    ActivitiesComment.find_by_sql ["DELETE FROM activities_comments where activity_id = ? and id = ?",@id,@commentId]
    redirect_to(@activity)
    
  end
  
  def showActivity
    
    idOrg = params[:activity][:id]
    @activity = Activity.find(idOrg)
    @title_description = @activity.name
  end


  def addActivityAsFavorite
    @pdUser =  PdUser.find(session[:pd_user_id])   
    activity = ActivitiesFavorite.find(:first, :conditions => { :pd_user_id => params[:Pduser_id], :activity_id => params[:activity_id]})
    if(activity == nil)  #if not found in database
      @favorite = ActivitiesFavorite.new(:pd_user_id =>params[:Pduser_id],:activity_id=>params[:activity_id])
      if @favorite.save
        return redirect_to  :controller => 'pd_user', :action => 'index'
      end
    end
    redirect_to  :controller => 'pd_user', :action => 'index'
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
    #1.times { @activity.programs.build }
    #1.times { @activity.categories.build }
    
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
    @activity.makeTags

    
    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(@activity) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
        @u = User.find_by_sql ["SELECT * FROM users where activitesadmin = ?","1"];
        #Note:  What if there are multiple activities admins, each should get an email
        if @u[0] and @u[0].mailpref    
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
  
  def postPhoto
  
	if( params[:photo_info][:filename].nil? )
		flash[:empty_photo] = "Oh no! You forgot to specify a filename!";
		redirect_to(:action => 'show',:id=>params[:photo_info][:activity_id]);
		return;
	end
  
	photo = Photo.new;
	photo.activity_id = params[:photo_info][:activity_id];
	photo.file_name = params[:photo_info][:filename].original_filename;
	photo.date_time = DateTime.now();
	photo.save();
	
	photo_dir = "#{GLOBALS::ACTIVITY_PATH}#{photo.activity_id}";
	
	FileUtils.mkdir_p photo_dir;
	if(File.directory?(photo_dir))
		FileUtils.mkdir_p(photo_dir);
	end
	photo_path =  "#{photo_dir}/#{photo.file_name}";
	File.open(photo_path,"wb") do |f|
		f.write(params[:photo_info][:filename].read());
	end
	
	flash[:upload_success] = "Photo Uploaded Successfully" 
	redirect_to(:action => 'show', :id => photo.activity_id);
	
  end
end
