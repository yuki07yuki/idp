class VisitorPass < ApplicationRecord




  def requested_at
    update_attribute(:requested_at, Time.zone.now)
  end

end
