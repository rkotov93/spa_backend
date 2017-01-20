# frozen_string_literal: true
class AddAvatarToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :avatar, :string
  end
end
