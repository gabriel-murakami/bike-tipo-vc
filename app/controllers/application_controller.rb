# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :due_date])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
