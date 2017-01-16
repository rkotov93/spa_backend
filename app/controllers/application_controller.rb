# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render status: :unauthorized
  end
end
