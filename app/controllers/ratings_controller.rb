class RatingsController < ApplicationController
  def rate
    @activity = Activity.find(params[:id])
    if(session[:pd_user_id])
    @pd_user = PdUser.find(session[:pd_user_id])
    Rating.delete_all(["rateable_type = 'Activity' AND rateable_id = ? AND user_id = ?", @activity.id, @pd_user.id])
    @activity.add_rating Rating.new(:rating => params[:rating], :user_id => @pd_user.id)
    end
  end

end
