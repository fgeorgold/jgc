require 'test_helper'

class PDUserControllerTest < ActionController::TestCase

  # Test a valid registration.
  def test_registration_success
    post :register, :pd_user => { :login_name => "test_name",
                                  :email => "test@email.com",
                                  :password => "test_password" }
    # Test assignment of pd_user.
    pd_user = assigns(:pd_user)

    # Make sure pd_user is logged in properly.
    assert_not_nil session[:pd_user_id]
    
    # Make sure that session user id matches the actual user id
    assert_equal pd_user.id, session[:pd_user_id]
  end
end
