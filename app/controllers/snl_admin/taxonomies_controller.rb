# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class TaxonomiesController < ApplicationController
    before_filter :set_taxonomy, except: [:index]
    respond_to :html

    def index
      @taxonomies = if params[:query]
        term = params[:query].strip
        conditions = "title ILIKE ?"
        SnlAdmin.taxonomy_class.where(conditions, "%#{term}%").
                            order('id asc')
      else
        SnlAdmin.taxonomy_class.order('id asc')
      end.page params[:page]
    end

    def show
      @title = taxonomy.title
    end

    def edit
      @title = t('edit_taxonomy')
    end

    def new
      @title = t('new_taxonomy')
    end

    def update
      if @taxonomy.update_attributes taxonomy_params
        respond_with @taxonomy
      else
        render :edit
      end
    end

    def create
      @taxonomy = SnlAdmin.taxonomy_class.new taxonomy_params
      if @taxonomy.save
        respond_with @taxonomy
      else
        render :new
      end
    end

    def destroy
      @taxonomy.destroy
      notice = t('destroy_taxonomy')
      redirect_to taxonomies_path, notice: notice
    end

    private

    def taxonomy
      @decorated_taxonomy ||= TaxonomyPresenter.new(@taxonomy, view_context)
    end
    helper_method :taxonomy

    def set_taxonomy
      @taxonomy = params[:id] ?
        SnlAdmin.taxonomy_class.find(params[:id]) :
        SnlAdmin.taxonomy_class.new
    end

    def taxonomy_params
      params.require(:taxonomy).permit(:title)
    end
  end
end
