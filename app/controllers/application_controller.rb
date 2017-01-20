# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.count
    }
  end

  def user_not_authorized
    render status: :unauthorized
  end
end
