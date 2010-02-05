class Zip < ActiveRecord::Base

  def find_nearby
    nearbyzips = []
    allzips = Zip.find(:all)
    for zip in allzips do
      if(calculateDistanceTo(zip) <= 1)
        nearbyzips.push zip
      end
    end
    nearbyzips
  end
  
  def get_zipcode(myzip)  #takes a zipcode (int) and returns a zip object
    allzips = Zip.find(:all)
    for zip in allzips do
      if(zip.code == myzip)
        return zip
      end
    end
    return nil;
  end
  
  def find_nearby_organizations
    @nearbyOrganizations = []
    
    nearbyzip = find_nearby  #get all nearby zips
    
    allorganizations = Organization.find(:all)
    for organization in allorganizations do

      for zip in nearbyzip do
        if(zip.code == organization.zipcode)
          @nearbyOrganizations.push organization
          break
        end
      end
      
    end 
    
    return @nearbyOrganizations
  end
  
  def calculateDistanceTo(zip)
    distance = (zip.lat - lat) * (zip.lat - lat) + (zip.lon - lon) * (zip.lon - lon)
    distance = Math.sqrt(distance)
  end


end