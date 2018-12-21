class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :waiver, :remember_me, :birthday, :first_name, :last_name, :phone, :address1, :address2, :city, :state, :zip, :emergency_contact_name, :emergency_contact_phone, :waiver_date]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
