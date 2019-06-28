class Article < ApplicationRecord
  
  belongs_to :user
  belongs_to :day_plan
  geocoded_by :address
  after_validation :geocode
  
end
