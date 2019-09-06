class Article < ApplicationRecord
  
  belongs_to :user
  has_many :DailyReports, dependent: :delete_all
  geocoded_by :address
  after_validation :geocode
  validates :title, presence: true
  validates :postcode, presence: true, format: { with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/}
  validates :address, presence: true
  validates :phone_num, presence: true, format: { with: /\A[0-9-]{,14}\z/ }
  
  
end
