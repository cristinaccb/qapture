class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  protected

  def after_sign_in_path_for(resource)
    home_path
  end
end
