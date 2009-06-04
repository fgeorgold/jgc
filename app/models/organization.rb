class Organization < ActiveRecord::Base
  has_many :partners
  has_many :asps
  after_update :save_partners
  
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :website
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  
  
  def asp_attributes=(asp_attributes)
    asp_attributes.each do |attributes|
      asps.build(attributes)      
    end
  end
  
  def partner_attribute=(partner_attribute)
    partner_attribute.each do |attribute|
     partners.build(attribute)
    end
  end
  
  def save_partners
    partners.each do |p|
      if p.should_destroy?
        p.destroy
      end
    end
  end
  
end
