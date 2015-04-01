class RegistrationsController < Devise::RegistrationsController
  def create
    if params[:t_and_c]
      super
    else
      flash[:error] = "You have to read and agree to the Terms & Conditions to sign up."
      redirect_to :back
    end
  end
end 