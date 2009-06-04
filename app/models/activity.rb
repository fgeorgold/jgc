class Activity < ActiveRecord::Base
  acts_as_rateable
  has_many :programs
  has_many :categories
  
  
  def program_attributes=(program_attributes)
    program_attributes.each do |attributes|
      programs.build(attributes)      
    end
  end
  
  def category_attributes=(category_attributes)
    category_attributes.each do |attributes|
      categories.build(attributes)      
    end   
  end

end
