class Statistics 
  attr_accessor :categories, :costs, :age_group, :duration
  
  def initialize()
    @categories = Hash.new
    @costs = Hash.new
    @age_group = Hash.new
    @duration = Hash.new
    @categories["Icebreakers"] =0
    @categories["Brain Teasers"] = 0
    @categories["General"] =0
    @categories["Homeworks"] =0
    @categories["Computer Related"] =0
    @costs["$0-$20"] = 0
    @costs["$20-$40"] = 0
    @costs["$40-$60"]= 0
    @costs["$60-$80"]= 0
    @costs["$80-$100"] =0
    @costs[">$100"] =0
    
    @age_group["0-8"]=0
    @age_group["8-10"]=0
    @age_group["10-12"]=0
    @age_group["12-14"]=0
    @age_group["14-16"]=0
    
    @duration["0-30min"] = 0
    @duration["30min-60min"] =0
    @duration["60min-90min"]=0
    @duration[">90min" ]=0
  end
end