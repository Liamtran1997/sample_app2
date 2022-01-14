class User < ApplicationRecord
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # Use downcase for all email before save to Db
  before_save {email.downcase!}

  validates :name, presence: true , length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX, message: "Vui long nhap lai Email"},
            uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
