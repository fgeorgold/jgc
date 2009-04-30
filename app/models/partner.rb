class Partner < ActiveRecord::Base
  belongs_to :organizations
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end