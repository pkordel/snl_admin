module SnlAdmin
  class ApplicationController < ActionController::Base

    protected

    def current_user
      return nil unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
      # user_id = request.session[:user_id]
      # user = User.find_by_id(user_id) if user_id
      # #TODO Remove this once session stops getting dropper
      # user ||= Struct.new(:id).new(1)
      # user
    end
  end
end
