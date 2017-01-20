# frozen_string_literal: true
class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, :user, presence: true
  validates :title, length: { maximum: 120 }

  mount_base64_uploader :avatar, AvatarUploader, file_name: 'avatar'
end
