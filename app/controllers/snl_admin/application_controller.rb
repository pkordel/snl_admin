module SnlAdmin
  class ApplicationController < ActionController::Base

    protected

    def current_user
      return nil unless session[:user_id]
      @current_user ||= SnlAdmin.user_class.find_by_id(session[:user_id])
    end
  end
end
