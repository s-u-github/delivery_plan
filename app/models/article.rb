class Article < ApplicationRecord
  
  belongs_to :user
  has_many :DailyReports, dependent: :delete_all
  geocoded_by :address
  after_validation :geocode
  
  validates :title, presence: true
  validates :postcode, presence: true, 
    format: { with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/, message: "が適切ではありません"}
  validates :address, presence: true
  validates :phone_num, presence: true, format: { with: /\A\d{10,11}\z/, message: "が適切ではありません"}
  
  
end
