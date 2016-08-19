class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  has_many :comments
  has_many :likes

  has_secure_password
end
