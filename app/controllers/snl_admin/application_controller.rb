module SnlAdmin
  class ApplicationController < ActionController::Base
    protected

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
