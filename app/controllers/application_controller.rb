# frozen_string_literal: true
class ApplicationController < ActionController::API
  protected

  def current_user
    User.first
  end
end
