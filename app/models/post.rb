class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, :user, presence: true
  validates :title, length: { maximum: 120 }
end
