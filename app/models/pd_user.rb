class PDUser < ActiveRecord::Base
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#
  # Max & min lengths for all fields  
  SCREEN_NAME_MIN_LENGTH = 4
  SCREEN_NAME_MAX_LENGTH = 30
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 10
  EMAIL_MAX_LENGTH = 50
  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  # Text box sizes for display in the views
  SCREEN_NAME_SIZE = 20
  PASSWORD_SIZE = 10
  EMAIL_SIZE = 30
  
  
  #***************************************************************#
  #******   U S E R     M O D E L     V A L I D A T I O N   ******#
  #***************************************************************#
  # Validate attribute :screen_name
  validates_uniqueness_of :screen_name
  validates_length_of :screen_name, :within => SCREEN_NAME_RANGE  
  validates_format_of :screen_name,
                      :with => /^[A-Z0-9_]*$/i,
                      :message => "must contain only letters, numbers, and underscores"
                      
  # Validate attribute :password
  validates_uniqueness_of :email
  validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
  validates_format_of :email,
                      :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                      :message => "must be a valid email address"

  # Validate attribute :password
  validates_length_of :password, :within => PASSWORD_RANGE
  
end
