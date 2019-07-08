# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_devise_params, if: :devise_controller?
  check_authorization unless: :devise_controller?

  def after_sign_in_path_for(resource)
    resource
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  protected

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
