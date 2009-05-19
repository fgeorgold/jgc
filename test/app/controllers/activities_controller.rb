
require 'set'
require 'acts_as_ferret'

class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.xml
  def index
    @activities = Activity.find(:all)

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
    
    @activity = Activity.find(@id)
    @program_id = Program.find_by_sql ["SELECT * FROM programs where activity_id = ?",@id];
    @category_id = Category.find_by_sql ["SELECT * FROM categories where activity_id = ?",@id]
    @programNames = []
    @categoryNames = []
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
  
  def showActivity
    idOrg = params[:activity][:id]
    @activity = Activity.find(idOrg)
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

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(@activity) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
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
