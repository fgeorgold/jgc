class ProfessionalLife < ActiveRecord::Base
  # The ProfessionalLife class declares that each professional_life belongs to a pd_user
  belongs_to :pd_user
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#  
  ALL_FIELDS = %w(start_date
                  past_work_experience
                  years_of_work
                  social_activities
                  skills future_plans
                  desired_job_description
                  desired_salary_per_year)
  # A constant for everything except the bio
  ALL_TEXT_FIELDS = ALL_FIELDS - %w(start_date years_of_work desired_salary_per_year)
  DB_TEXT_MAX_LENGTH          = 40000  
  TEXT_ROWS                   = 5
  TEXT_COLUMNS                = 40
  NUMBER_TEXT_BOX_LENGTH      = 4  
  START_YEAR                  = 1960
  VALID_DATES                 = DateTime.new(START_YEAR)..DateTime.now
  MIN_SALARY                  = 0
  MAX_SALARY                  = 100000000
  SALARY_RANGE                = MIN_SALARY..MAX_SALARY
  MIN_WORK_EXPERIENCE_YEARS   = 0
  MAX_WORK_EXPERIENCE_YEARS   = 100
  WORK_EXPERIENCE_YEARS_RANGE = MIN_WORK_EXPERIENCE_YEARS..MAX_WORK_EXPERIENCE_YEARS
  
  #*****************************************************#
  #******   P R O F E S S I O N A L  _  L I F E   ******#
  #******    M O D E L     V A L I D A T I O N    ******#
  #*****************************************************#
  # Validate the length of the ALL_FIELDS
  # to make sure that the submitted text isn't too absurdly huge
  validates_length_of ALL_TEXT_FIELDS, :maximum => DB_TEXT_MAX_LENGTH
  
  # Validate attribute :start_date
  validates_inclusion_of :start_date,
                         :in => VALID_DATES,
                         :allow_nil => true,
                         :message => "is an invalid or a future date"
                         
  # Validate attribute :desired_job_salary
  validates_numericality_of :desired_salary_per_year,
                            :only_integer => true,
                            :allow_nil => true,
                            :message => "can only be whole number."                            
  validates_inclusion_of :desired_salary_per_year,
                         :within => SALARY_RANGE,
                         :allow_nil => true,
                         :message => "can only be between #{MIN_SALARY} and #{MAX_SALARY}"
  
  # Validate attribute :num_of_work_experience_years
  validates_inclusion_of :years_of_work,
                         :within => WORK_EXPERIENCE_YEARS_RANGE,
                         :allow_nil => true,
                         :message => "can only be between #{MIN_WORK_EXPERIENCE_YEARS} and #{MAX_WORK_EXPERIENCE_YEARS}"
  
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
    
    ALL_TEXT_FIELDS.each do |field|
      self[field] = ""
    end
  end

end
