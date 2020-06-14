class VisitorPass < ApplicationRecord

  validates(:visitors_name,         presence: true, length: {maximum: 50})
  validates(:resident_id,           presence: true, length: {maximum: 50})
  validates(:visitors_email,        presence: true, length: {maximum: 50})
  validates(:token,                 presence: true, length: {maximum: 50})
  validates(:secret_key,            presence: true, length: {maximum: 50})



  def requested_at_now
    update_attribute(:requested_at, Time.zone.now)
  end

end
