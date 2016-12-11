# frozen_string_literal: true
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author
  attribute :errors, if: :errors_presented?

  def author
    object.user.try(:name)
  end

  def errors_presented?
    object.errors.present?
  end
end
