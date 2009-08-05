require 'digest/sha1' # Needed for the hashing generation of the authorization_token

class PdUser < ActiveRecord::Base
  # The PdUser class declares that each pd_user has one spec
  has_one :spec
  # The PdUser class declares that each pd_user has one personal_life
  has_one :personal_life
  # The PdUser class declares that each pd_user has one professional_life
  has_one :professional_life
  
  # Way to create a remember_me attribute in the PdUser class
  # without introducing a new column name in the database.  
  attr_accessor :remember_me
  
  #***************************************************************#
  #******     C O N S T A N T     D E C L A R A T I O N     ******#
  #***************************************************************#
  # Max & min lengths for all fields  
  LOGIN_NAME_MIN_LENGTH = 4
  LOGIN_NAME_MAX_LENGTH = 30
  PASSWORD_MIN_LENGTH   = 4
  PASSWORD_MAX_LENGTH   = 10
  EMAIL_MAX_LENGTH      = 50
  LOGIN_NAME_RANGE      = LOGIN_NAME_MIN_LENGTH..LOGIN_NAME_MAX_LENGTH
  PASSWORD_RANGE        = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
  
  # Text box sizes for display in the views
  LOGIN_NAME_SIZE = 20
  PASSWORD_SIZE   = 10
  EMAIL_SIZE      = 30
  
  # Cookie expiration
  COOKIE_EXPIRATION = 10.years.from_now
  
  #*******************************************************************#
  #******   P D U S E R     M O D E L     V A L I D A T I O N   ******#
  #*******************************************************************#
  # Validate attribute :login_name
  validates_uniqueness_of :login_name
  validates_length_of :login_name, :within => LOGIN_NAME_RANGE 
  validates_format_of :login_name,
                      :with => /^[A-Z0-9_]*$/i,
                      :message => "must contain only letters, numbers, and underscores"
                      
  # Validate attribute :email
  validates_uniqueness_of :email
  validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
  validates_format_of :email,
                      :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                      :message => "must be a valid email address"
                      
  # Current password is the last known valid password
  attr_accessor :current_password
  # Validate attribute :password
  validates_length_of :password, :within => PASSWORD_RANGE
  # Make sure that the :password_confirmation matches the :password  
  validates_confirmation_of :password


  #################################
  #       R E M E M B E R !       #
  #################################
  # Remember a user for future login.
  def remember!(cookies)
    cookies[:remember_me] = {:value => "1",
                             :expires => COOKIE_EXPIRATION }
                              
    self.authorization_token = unique_identifier
    self.save!
    cookies[:authorization_token] = {:value => self.authorization_token,
                                     :expires => COOKIE_EXPIRATION }
  end
  
  #############################
  #       F O R G E T !       #
  #############################
  # Forget a user's login status.
  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end
  
  #####################################
  #       R E M E M B E R M E ?       #
  #####################################
  # Return true if the user wants the login status remembered.
  def remember_me?
    return (self.remember_me == "1")
  end  
  
  #############################################
  #       C L E A R   P A S S W O R D !       #
  #############################################
  # Clear the password (typically to suppress its display in a view).
  def clear_password!
    unless (self.password.nil?)
      self.password = nil
    end
    
    unless (self.password_confirmation.nil?)
      self.password_confirmation = nil
    end  
    
    unless (self.current_password.nil?)
      self.current_password = nil
    end  
  end
  
  ###############################################
  #       C O R R E C T   P A S S W O R D       #
  ###############################################  
  # Return true if the password from params is correct.
  def correct_password?(params)
    current_password = params[:pd_user][:current_password]
    return (password == current_password)
  end

  #############################################
  #       P A S S W O R D   E R R O R S       #
  #############################################  
  # Generate messages for password errors.
  def password_errors(params)
    # Use PdUser model's valid? method to generate error messages
    # for a password mismatch (if any).
    self.password = params[:pd_user][:password]
    self.password_confirmation = params[:pd_user][:password_confirmation]
    valid?
    # The current password is incorrect, so add an error message.
    errors.add(:current_password, "is incorrect")
  end

  ###########################
  #       L O G I N !       #
  ###########################  
  # Log a user in.
  def login!(session)
    session[:pd_user_id] = self.id
  end  

  #############################
  #       L O G O U T !       #
  #############################  
  # Log a user out.
  #
  # Class method.
  def self.logout!(session, cookies)
    session[:pd_user_id] = nil  
    cookies.delete(:authorization_token)
  end
  
  #######################
  #       N A M E       #
  #######################  
  # Return a sensible name for the user.
  def name
    # If you activate lib/String.rb enable the next line
    # spec.full_name.or_else(login_name)
    spec.full_name
  end 

  #############################################################
  #############################################################
  ##               H    E    L    P    E    R                ##
  ##        F    U    N    C    T    I    O    N    S        ## 
  #############################################################
  #############################################################
  # All functions that follow will be made private
  # => not accessible for outside objects 
  private
  
  #################################################
  #       U N I Q U E   I D E N T I F I E R       #
  #################################################
  # Generate a unique identifier for a user
  # We can call directly Digest::SHA1.hexdigest, but it's better to build
  # an abstraction layer between the unique identifier used to remember 
  # the user and the algorithm used to generate it
  def unique_identifier
    Digest::SHA1.hexdigest("#{login_name}:#{password}")
  end 
  
end
