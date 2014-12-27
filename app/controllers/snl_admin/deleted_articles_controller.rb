# -*- encoding : utf-8 -*-

require_dependency "snl_admin/application_controller"

module SnlAdmin
  class DeletedArticlesController < ApplicationController
    def index
      @deleted_articles = SnlAdmin.deleted_article_class.recent.page params[:page]
    end
    def show
      @deleted_article = SnlAdmin.deleted_article_class.find params[:id]
    end
  end
end
