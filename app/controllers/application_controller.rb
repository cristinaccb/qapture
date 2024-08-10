class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

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
