class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include CanCan::ControllerAdditions
  # after_action :check_authorization

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:name, :email, :contact, :password, user_image_attributes: [:picture])
    end
  end
end
