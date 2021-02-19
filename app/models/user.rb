class User < ApplicationRecord
  require 'digest'

  REGEX_PASSWORD = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}/
  REGEX_EMAIL = URI::MailTo::EMAIL_REGEXP

  validates_presence_of :nickname, :email, :password, :country
  validates :password, length:{minimum:8,maximum:32}, format: { with: REGEX_PASSWORD }, on: :create
  validates :nickname, uniqueness: true, length:{minimum:5,maximum:20}
  validates :email, uniqueness: true, length:{minimum:6,maximum:32}, format: { with: REGEX_EMAIL }

  before_create -> {self.password = Digest::SHA256.new << self.password }
end
