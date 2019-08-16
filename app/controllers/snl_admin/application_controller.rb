module SnlAdmin
  class ApplicationController < ActionController::Base
    protected

    def current_user
      return nil unless session[:user_id]

      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def view_url(permalink, subdomain: nil, anchor: nil)
      host      = request.domain || request.host
      fullpath  = request.protocol.to_s
      fullpath += "#{subdomain}." unless subdomain.blank?
      fullpath += "#{host}#{request.port_string}/#{permalink}"
      fullpath += "##{anchor}" unless anchor.blank?
      fullpath
    end
    helper_method :view_url

    def nullify_unless_valid_integer(value)
      return if value.blank? || value.is_a?(Hash)

      Integer(value)
    rescue ArgumentError => e
      logger.warn("Failed to parse param to integer: #{e}")
      nil
    end
    helper_method :nullify_unless_valid_integer
  end
end
