
require 'acts_as_ferret'

class OrganizationsController < ApplicationController
  # GET /organizations
  # GET /organizations.xml
  
  before_filter :login_required, :only=>['edit','update','destroy','new']
  
  

  
  def index
    @title_description = "John Gardner Center"
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
    
    @id = params[:id]
    @organization = Organization.find(@id)
    @title_description = @organization.name
    @partner_id = Partner.find_by_sql ["SELECT * FROM partners where organization_id = ?",@id];
    @partnerNames = []
    for currentPartner in @partner_id
         partnerID =  currentPartner.partner_org_id 
         @partnerOrganization = Organization.find(partnerID)
         @partnerNames.push @partnerOrganization.name
    end
     
    respond_to do |format|
       
         format.html # show.html.erb
         format.xml  { render :xml => @organization }
    end
  end
  
  
  def showOrg
    
    idOrg = params[:organization][:id]
    @organization = Organization.find(idOrg)
    @title_description= @organization.name
    redirect_to(@organization)

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
    @title_description = "Creating a new organization"
    allorganizations = Organization.find(:all)
    @organizations = Hash.new

    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.merge!({organization.name => organization.id})
        end
    end

    @organization = Organization.new
    1.times { @organization.partners.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    
    @id = params[:id]
    @Neworganization = Organization.find(params[:id])
    @title_description = @Neworganization.name
    allorganizations = Organization.find(:all)
    @organizations = Hash.new
    
    
    @partner_id = Partner.find_by_sql ["SELECT * FROM partners where organization_id = ?",@id];
    @partnerNames = []
    for currentPartner in @partner_id
         partnerID =  currentPartner.partner_org_id 
         @partnerOrganization = Organization.find(partnerID)
         @partnerNames.push @partnerOrganization.name
    end
    
    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.merge!({organization.name => organization.id})
        end
    end
    
    if(@Neworganization.name != session[:user].affiliateOrg && session[:user].admin == false)
      redirect_to_stored
    end 
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    @Neworganization = Organization.new(params[:organization])
    @userC = session[:user]
    allorganizations = Organization.find(:all)
    @organizations = Hash.new

    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.merge!({organization.name => organization.id})
        end
    end

    @organization = Organization.new
    1.times { @organization.partners.build }
  
    respond_to do |format|
      if @Neworganization.save
        flash[:notice] = 'Organization was successfully created.'
        @userC.update_attribute(:affiliateOrg,@Neworganization.name)
        format.html { redirect_to(@Neworganization) }
        format.xml  { render :xml => @Neworganization, :status => :created, :location => @organization }
        @u = User.find_by_sql ["SELECT * FROM users where admin = ?","1"];

        if @u[0].mailpref    
        subject = "New organization has been created"
        to = @u[0].email
        from = 'helpjgc@gmail.com'
        mail = 'A new Organization: '+ @organization.name+' has been created by '+ @userC.login + ' .Kindly review and approve the organization'
        email = Emails.new
        email.from = from
        email.to = to
        email.mail = mail
        email.subject = subject
        email.save
       end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @Neworganization.errors, :status => :unprocessable_entity }
      end
    end
  end



  
  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @org_id = params[:id]
    @Neworganization = Organization.find(params[:id])
    @userC = session[:user]
    @organization = Organization.find(params[:id])
    allorganizations = Organization.find(:all)
    @organizations = Hash.new
    
    
    @partner_id = Partner.find_by_sql ["SELECT * FROM partners where organization_id = ?",@id];
    @partnerNames = []
    for currentPartner in @partner_id
         partnerID =  currentPartner.partner_org_id 
         @partnerOrganization = Organization.find(partnerID)
         @partnerNames.push @partnerOrganization.name
    end
    
    for organization in allorganizations do
        if(organization.visible== true)
          @organizations.merge!({organization.name => organization.id})
        end
    end
    
    if @Neworganization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        @userC.update_attribute(:affiliateOrg,@Neworganization.name)
        redirect_to(@Neworganization)
    else
        render :action => "edit" 
        
    end
   
 end
 
 def RemovePartner
    @idOrg = params[:id]
    @partnerName = params[:name]
    @partner= Organization.find_by_sql["SELECT id FROM organizations where name =?",@partnerName]
    @row_id = Partner.find_by_sql["SELECT id FROM partners where organization_id =? and partner_org_id =?",@idOrg,@partner]
    Partner.destroy(@row_id.id)
    redirect_to(organizations_url)
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

  
end
