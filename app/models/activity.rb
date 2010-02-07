class Activity < ActiveRecord::Base
  acts_as_ferret
  acts_as_rateable



  has_many :programs
  has_many :categories
  has_many :activities_comments
  has_many :photos
  has_and_belongs_to_many :tags
  belongs_to :pd_user
  
  
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

  def makeTags
    tags2 = taggedAs.split(',')
    for tag in tags2
      self.tags.build(:description => (tag.downcase.strip))
    end
  end

end
