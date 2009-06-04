class PersonalLife < ActiveRecord::Base
  # The PersonalLife class declares that each personal_life belongs to a pd_user
  belongs_to :pd_user
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#  
  ALL_FIELDS = %w(bio
                  academic_background
                  interests
                  other_info)
  # A constant for everything except the bio
  ALL_FIELDS_EXCLUDING_BIO = ALL_FIELDS - %w(bio)
                  
  DB_TEXT_MAX_LENGTH = 40000  
  TEXT_ROWS          = 5
  TEXT_COLUMNS       = 40
  
  #***************************************************#
  #******      P E R S O N A L  _  L I F E      ******#
  #******   M O D E L     V A L I D A T I O N   ******#
  #***************************************************#
  # Validate the length of the ALL_FIELDS
  # to make sure that the submitted text isn't too absurdly huge
  validates_length_of ALL_FIELDS, :maximum => DB_TEXT_MAX_LENGTH
  
  ###################################
  #       I N I T I A L I Z E       #
  ###################################
  # If a class inherits from another class, there is no need to define an initialize
  # function since the parents class's initialize function will be called automatically.
  # Since our model inherits from ActiveRecord::Base we can rely on the initialization function
  # in the parent class. However, we need to define our own initialize (override the parent 
  # initialize funcion, since we want to set the default text for each question to "".
  def initialize
    # Since we want the ProfessionalLife model to be a proper ActiveRecord class,
    # we need to call the initialize function of the superclass first
    super 
    
    ALL_FIELDS.each do |field|
      self[field] = ""
    end
  end
  
end
