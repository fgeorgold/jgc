class ActivitiesFavorite < ActiveRecord::Base
  belongs_to :pd_user

  def getActivity
    actualActivity = Activity.find(activity_id)
    return actualActivity
  end
end
