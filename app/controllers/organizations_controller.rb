
require 'acts_as_ferret'

class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.xml
  
  before_filter :login_required, :only=>['edit','update','destroy','new']
  
  

  
  def index
    allorganizations = Organization.find(:all)
    @posts = Organization.find_by_contents("american")
    @organizations = []

    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.push organization
        end
    end

    respond_to do |format|
      format.html # index.html.erb
      
      format.xml  { render :xml => @organizations }
    end
  end
  
  def populate
    
  end

  # GET /organizations/1
  # GET /organizations/1.xml
  def show

    @organization = Organization.find(params[:id])
    respond_to do |format|
       
         format.html # show.html.erb
         format.xml  { render :xml => @organization }
    end
  end
  
  
  def showOrg
    idOrg = params[:organization][:id]
    @organization = Organization.find(idOrg)

  end
  
   def add_partner
    allorganizations = Organization.find(:all)
    @porganizations = []
    for vorganization in allorganizations do
        if(vorganization.visible== true)
          @porganizations.push vorganization
        end
    end
    render :partial => "add_partner"

end

def add_selectedOrg
  orgID = params[:organization][:id]
  @organization = Organization.find(orgID)
  orgName = @organization.name
  render :text => "<br>"+orgID
  
end
  
   
  
  def privatepreview()
    @currentUser = session[:user]
  end

  # GET /organizations/new
  # GET /organizations/new.xml
  def new
    @types_all = [["Car", "car"], ["SUV", "suv"], ["Truck", "truck"]]
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
    if(@organization.name != session[:user].affiliateOrg && session[:user].admin == false)
      redirect_to_stored
    end 
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    @organization = Organization.new(params[:organization])
    @userC = session[:user]
    @userC.update_attribute(:affiliateOrg,@organization.name)

    respond_to do |format|
      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to(@organization) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
      format.xml  { head :ok }
    end
  end
  
    # these are just some constants.  Most likely you'll want to find things 
  # in your database to return.
  TYPES = {"car" => [["Honda Accord", "1"], ["Scion Tc", "2"], 
                     ["Ford Focus", "3"], ["BMW M6", "4"]],
           "suv" => [["Jeep Wrangler", "5"], ["Ford Explorer", "6"], 
                     ["Toyota Highlander", "7"]],
           "truck" => [["Ford F150", "8"], ["Dodge Ram", "9"]] }
  

  def update_list
    @vehicles_all = []
    if params[:types]
      params[:types].each do |t|
        @vehicles_all = @vehicles_all.concat(TYPES[t])
      end
    end
    # this part is really important, if you don't tell it not to render the 
    # layout, the area where your selection box is will have the whole 
    # controller's layout around it.
    render :layout => false
  end
  
  def test

  end
  
end
