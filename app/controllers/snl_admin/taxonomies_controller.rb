# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class TaxonomiesController < ApplicationController
    def index
      @taxonomies = if params[:query]
        term = params[:query].strip
        conditions = "title ILIKE ?"
        SnlAdmin.taxonomy_class.where(conditions, "%#{term}%").
                            order('title asc')
      else
        SnlAdmin.taxonomy_class.order('title asc')
      end.page params[:page]
    end
  end
end
