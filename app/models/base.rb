class Base < ApplicationRecord
  
  has_many :users
  
  validates :base_name, presence: true


end