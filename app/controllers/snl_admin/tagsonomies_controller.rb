# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class TagsonomiesController < ApplicationController
    before_filter :set_tagsonomy, except: [:index]
    respond_to :html

    def index
      @tagsonomies = if params[:query]
        term = params[:query].strip
        conditions = "title ILIKE ?"
        SnlAdmin.tagsonomy_class.where(conditions, "%#{term}%").
                            order('title asc')
      else
        SnlAdmin.tagsonomy_class.order('title asc')
      end.page params[:page]
    end

    def show
      @title = tagsonomy.title
    end

    def edit
      @title = t('edit_tagsonomy')
    end

    def new
      @title = t('new_tagsonomy')
    end

    def update
      if @tagsonomy.update_attributes tagsonomy_params
        respond_with @tagsonomy
      else
        render :edit
      end
    end

    def create
      @tagsonomy = SnlAdmin.tagsonomy_class.new tagsonomy_params
      if @tagsonomy.save
        respond_with @tagsonomy
      else
        render :new
      end
    end

    def destroy
      unless @tagsonomy.has_children?
        @tagsonomy.destroy
        notice = t('destroy_tagsonomy')
      else
        notice = t('destroy_tagsonomy_forbidden')
      end
      redirect_to tagsonomies_path, notice: notice
    end

    private

    def tagsonomy
      @decorated_tagsonomy ||= TagsonomyPresenter.new(@tagsonomy, view_context)
    end
    helper_method :tagsonomy

    def set_tagsonomy
      @tagsonomy = params[:id] ?
        SnlAdmin.tagsonomy_class.find(params[:id]) :
        SnlAdmin.tagsonomy_class.new
    end

    def tagsonomy_params
      params.require(:tagsonomy).permit(:title, :type, parent_ids: [])
    end

    def collection_for_parent_id record
      record_id = record.id || 0
      Tagsonomy.where("id != ? AND type = ? ", record_id, record.type).collect {|t| [t.title, t.id] }
    end
    helper_method :collection_for_parent_id

    def format_string(string, node)
      [string, "(#{node.type}) #{node.title}"].compact.join(" | ")
    end
  end
end
