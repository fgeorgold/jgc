class CommunityController < ApplicationController
  helper :profile
  # Use the pd_user layout (i.e., views/layout/pd_user.html.erb)
  layout "pd_user"  
  
  # Helper :profile is required since index uses the 
  # function profile_for to link to user profiles

  #########################
  #       I N D E X       #
  #########################
  def index
    @title = "Community"
    @letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("") # Create an array of strings, 
                                                      # one for each letter of the alphabet
                                                      # %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
                                                      # would work as well
    if (params[:id] != nil)
      @initial = params[:id]
      
      # Without pagination
      specs = Spec.find(:all,
                        :conditions => ["last_name like ?", @initial+'%'],
                        :order => "last_name, first_name")
      # Paginate (paginate returns a two-element array)
      # This required the will_paginate plugin
      # To install it you give: gem install will_paginate --no-ri 
      # Add also the following to environment.erb:
      #    require 'will_paginate'
      #@pages, specs = paginate(:specs,
      #                         :conditions => ["last_name LIKE ?", @initial+"%"],
      #                         :order => "last_name, first_name")

      # Go through specs and collect an array of the corresponding pd_users
      @pd_users = specs.collect { |spec|
                    spec.pd_user
                  }
    end
  end

  ###########################
  #       B R O W S E       #
  ###########################
  def browse
    @title = "Browse"
    
    # Trick: return if the form hasn't been submitted causing
    #        Rails to render the browse form immediately
    if (params[:commit] == nil)
      return
    end
    
    specs = Spec.find_by_fields(params)
    
    @pd_users = []
    @pd_users.concat(specs.collect { |spec|
                       spec.pd_user
                     }).uniq!
                    
    # Sort the results by last name (requires a spec for each pd_user)
    @pd_users.each { |pd_user| 
                 pd_user.spec ||= Spec.new
               }
                
    @pd_users = @pd_users.sort_by { |pd_user|
                            pd_user.spec.last_name
                          }                              
  end

  ###########################
  #       S E A R C H       #
  ###########################
  def search
    @title = "Search Community"
    
    if params[:q]
      query = params[:q]
        
      # First find the pd_user hits...
#      @pd_users = PdUser.find_by_contents(query, :limit => :all) # Feret
      # ...then the subhits
#      specs = Spec.find_by_contents(query, :limit => :all) # Feret
#      personal_lives = PersonalLife.find_with_ferret(query, :limit => :all) # Feret    
#      professional_lives = ProfessionalLife.find_with_ferret(query, :limit => :all) # Feret    
      
      # Now combine into one list (using 'concat') 
      # of distinct (using 'uniq!') pd_users
#      hits = specs # + personal_lives + professional_lives
#      @pd_users.concat(hits.collect { |hit|
#                  hit.pd_user
#                }).uniq!
      
      # Sort the results by last name (requires a spec for each pd_user)
#     @pd_users.each { |pd_user| 
#                  pd_user.spec ||= Spec.new
#                }
#      @pd_users = @pd_users.sort_by { |pd_user|
#                              pd_user.spec.last_name
#                            }
                  
      # Paginate the results            
      #@pages, @pd_users = paginate(@pd_users)  
    end
  end

end


