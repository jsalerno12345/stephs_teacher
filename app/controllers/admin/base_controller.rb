# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
    before_action :require_login
  
    private
  
    def require_login
      unless current_user
        redirect_to login_path, alert: "You must be logged in to access this section."
      end
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    helper_method :current_user # allows `current_user` to be used in views
  end
  