# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password

  has_many :posts

  validates :name, :email, presence: true
  validates :email, email: true, uniqueness: true
end
