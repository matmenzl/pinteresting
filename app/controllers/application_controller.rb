class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :set_locale
 
 protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :address, :zip, :street, :city, :country]
    devise_parameter_sanitizer.for(:account_update) << [:name, :phone]
  end

  # Check if user has permission to see the pin (by location)
  def validate_location
    unless Pin.find(params[:id]).is_near? current_user
      flash[:notice] = "Sorry, but this pin isn't located in your area!"
      redirect_to root_path
    end
  end

  def set_locale
    if cookies[:user_locale] && I18n.available_locales.include?(cookies[:user_locale].to_sym)
      loc = cookies[:user_locale].to_sym
    else
      loc = http_accept_language.compatible_language_from(I18n.available_locales)
      cookies.permanent[:user_locale] = loc
    end
    I18n.locale = loc
  end
end
