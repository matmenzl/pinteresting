class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 before_action :configure_permitted_parameters, if: :devise_controller?

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
end
