# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class RedirectionsController < ApplicationController
    respond_to :html

    def index
      @redirections = if params[:query]
        term = params[:query].strip
        conditions = "urlpath ILIKE ? OR headword ILIKE ? OR clarification ILIKE ?"
        Redirection.where(conditions, "%#{term}%", "%#{term}%", "%#{term}%").
             order('headword asc')
      else
        Redirection.order('headword asc')
      end.page params[:page]
    end

  end
end