class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  protected

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def update
    if params[:id] == "sign_out"
      sign_out current_user
      redirect_to root_path, notice: "You have been signed out."
      return
    end
  end

end
