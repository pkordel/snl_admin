# -*- encoding : utf-8 -*-

require_dependency "snl_admin/application_controller"

module SnlAdmin
  class DeletedArticlesController < ApplicationController
    def index
      @deleted_articles = SnlAdmin.deleted_articles_class.order('created_at desc').page params[:page]
    end
  end
end
