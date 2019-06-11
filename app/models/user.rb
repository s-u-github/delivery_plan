class User < ApplicationRecord
  
  before_save { self.email = email.downcase } # データベース保存時、小文字で保存
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  # 正規表現
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }, # フォーマット指定
                    uniqueness: { case_sensitive: false } # 一意性検証かつ大文字小文字の区別
  VALID_PHONE_REGEX = 
  /\A(((0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1}|
  [5789]0[-(]?\d{4})[-)]?)|\d{1,4}\-?)\d{4}|0120[-(]?\d{3}[-)]?\d{3})\z/
  validates :phone_num, presence: true, format: { with: VALID_PHONE_REGEX }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
