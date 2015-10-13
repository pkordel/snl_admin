require_dependency "snl_admin/application_controller"

module SnlAdmin
  class DeletedArticlesController < ApplicationController
    def index
      @deleted_articles = SnlAdmin.article_class.deleted.page params[:page]
    end

    def show
      @deleted_article = SnlAdmin.article_class.find params[:id]
    end
  end
end
