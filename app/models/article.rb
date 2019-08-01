class Article < ApplicationRecord
  
  belongs_to :user
  has_many :DailyReports
  geocoded_by :address
  after_validation :geocode
  
end
