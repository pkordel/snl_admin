module SnlAdmin
  class ApplicationController < ActionController::Base
    protected

    def organization
      @organization ||= Organization.find_by(domain_name: Conf.host) ||
                        Organization.default
    end
    helper_method :organization

    def current_user
      return nil unless session[:user_id]
      @current_user ||= SnlAdmin.user_class.find_by_id(session[:user_id])
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
  end
end
