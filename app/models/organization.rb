
require 'acts_as_ferret'


class Organization < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :website
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  
  
  acts_as_ferret 
  
end
