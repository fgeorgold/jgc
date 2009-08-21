
class ActivitiesComment < ActiveRecord::Base
  belongs_to :activities
  validates_presence_of  :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,:message => "Invalid email"
end
