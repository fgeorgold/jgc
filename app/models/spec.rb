class Spec < ActiveRecord::Base
  # The Spec class declares that each spec belongs to a pd_user
  belongs_to :pd_user
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#  
  ALL_FIELDS    = %w(first_name last_name occupation current_employee age_group gender birthdate address city state zip_code)
  STRING_FIELDS = ALL_FIELDS - %w(gender birthdate zip_code)
  VALID_GENDERS = ["Male", "Female"]
  DB_STRING_MAX_LENGTH        = 255  
  START_YEAR                  = 1900
  VALID_DATES                 = DateTime.new(START_YEAR)..DateTime.now
  ZIP_CODE_LENGTH             = 5
  CURR_EMPLOYEE_TEXT_LENGTH   = 27  
  
  #***************************************************************#
  #******   S P E C     M O D E L     V A L I D A T I O N   ******#
  #***************************************************************#
  # Validate the length of the STRING_FIELDS
  validates_length_of STRING_FIELDS, :maximum => DB_STRING_MAX_LENGTH
  
  # Validate attribute :gender
  validates_inclusion_of :gender,
                         :in => VALID_GENDERS,
                         :allow_nil => true,
                         :message => "must be male or female"
                         
  # Validate attribute :birthdate
  validates_inclusion_of :birthdate,
                         :in => VALID_DATES,
                         :allow_nil => true,
                         :message => "is an invalid or a future date"
                         
  # Validate attribute :zip_code
  validates_format_of :zip_code, 
                      :with => /(^$|^[0-9]{#{ZIP_CODE_LENGTH}}$)/,
                      :allow_nil => false,
                      :message => "must be a five digit number"
                      
  #################################
  #       F U L L _ N A M E       #
  #################################  
  # To get the full name (first plus last), use the join method to join array
  # elements together, separated by a particular string (in this case, a space).
  def full_name
    [first_name, last_name].join(" ")
  end
  
  #####################
  #       A G E       #
  #####################  
  # Return the age using the birthdate.
  def age
    if (birthdate == nil)
      return
    end
  
    today = Date.today
    if ((today.month >= birthdate.month) and (today.day >= birthdate.day))
      # Birthday has happened already this year.
      today.year - birthdate.year
    else
      today.year - birthdate.year - 1
    end
  end
  
  ###############################
  #       L O C A T I O N       #
  ###############################  
  # To get the location, use the join method to join array elements
  # together, separated by a particular string (in this case, a space).
  def location
    return [city, state, zip_code].join(" ")
  end
  
  ###########################################
  #       F I N D _ B Y _ F I E L D S       #
  ###########################################
  # Find by age, sex, location.
  def self.find_by_fields(params)
    where = []
    
    # Set up the name restriction in SQL
    unless (params[:first_name].blank?) 
      where << "first_name = :first_name"
    end    
    unless (params[:last_name].blank?) 
      where << "last_name = :last_name"
    end

    # Set up the gender restriction in SQL
    unless (params[:gender].blank?)  
          where << "gender = :gender" 
    end   

    # Set up the address restriction in SQL
    unless (params[:address].blank?)  
          where << "address = :address" 
    end
    
    # Set up the city restriction in SQL
    unless (params[:city].blank?)  
          where << "city = :city" 
    end

    # Set up the state restriction in SQL
    unless (params[:state].blank?)  
          where << "state = :state" 
    end

    # Set up the zip-code restriction in SQL
    unless (params[:zip_code].blank?)  
          where << "zip_code = :zip_code" 
    end
    
    # Set up the current_employee restriction in SQL
    unless (params[:current_employee].blank?) 
      where << "current_employee = :current_employee"
    end    
    
    # Set up the age_group restriction in SQL
    unless (params[:age_group].blank?) 
      where << "age_group = :age_group"
    end 
    
    if (where.empty?)
      # If there are no restrictions => return an empty array
      []
    else
      if (params[:logic_function] == 'AND')
        find(:all,
             :conditions => [where.join(" AND "), params],
             :order => "last_name, first_name")
      else
        find(:all,
             :conditions => [where.join(" OR "), params],
             :order => "last_name, first_name")
      end        
    end
  end
 
end