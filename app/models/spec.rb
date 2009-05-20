class Spec < ActiveRecord::Base
  # The Spec class declares that each spec belongs to a user
  belongs_to :pd_user
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#  
  ALL_FIELDS    = %w(first_name last_name occupation gender birthdate city state zip_code)
  STRING_FIELDS = %w(first_name last_name occupation city state)
  VALID_GENDERS = ["Male", "Female"]
  DB_STRING_MAX_LENGTH = 255  
  START_YEAR = 1900
  VALID_DATES = DateTime.new(START_YEAR)..DateTime.now
  ZIP_CODE_LENGTH = 5
  
  #***************************************************************#
  #******   S P E C     M O D E L     V A L I D A T I O N   ******#
  #***************************************************************#
  validates_length_of STRING_FIELDS, :maximum => DB_STRING_MAX_LENGTH

  # Validate attribute :first_name
  validates_presence_of :first_name

  # Validate attribute :last_name
  validates_presence_of :last_name
  
  # Validate attribute :gender
  validates_inclusion_of :gender,
                         :in => VALID_GENDERS,
                         :allow_nil => true,
                         :message => "must be male or female"
                         
  # Validate attribute :birthdate
  validates_inclusion_of :birthdate,
                         :in => VALID_DATES,
                         :allow_nil => true,
                         :message => "is invalid"
                         
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
  
  ###############################
  #       L O C A T I O N       #
  ###############################  
  # To get the location, use the join method to join array elements
  # together, separated by a particular string (in this case, a space).
  def location
    return [city, state, zip_code].join(" ")
  end                      
end