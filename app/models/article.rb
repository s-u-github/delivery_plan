class Article < ApplicationRecord
  
  belongs_to :user
  has_many :DailyReports, dependent: :delete_all
  geocoded_by :address
  after_validation :geocode
  
  validates :title, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :phone_num, presence: true
  
  
end
