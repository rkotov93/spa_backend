class PostSerializer < ActiveModel::Serializer
  attributes :title, :body, :author

  def author
    user.name
  end
end
