class User < ApplicationRecord
  
  before_save { self.email = email.downcase } # データベース保存時、小文字で保存
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  # 正規表現
  validates :email, presence: ture, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }, # フォーマット指定
                    uniqueness: { case_sensitive: false } # 一意性検証かつ大文字小文字の区別
  
  
end
