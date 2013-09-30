# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class RedirectionsController < ApplicationController
    before_filter :set_redirection
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

    def new
      @title = t('new_redirection')
    end

    def edit
      @title = t('edit_user')
    end

    def show
    end

    def create
      @redirection = SnlAdmin.redirection_class.new redirection_params
      if @redirection.save
        respond_with @redirection
      else
        render :new
      end
    end

    def update
      if @redirection.update_attributes redirection_params
        respond_with @redirection
      else
        render :edit
      end
    end

    def destroy
      @redirection.destroy
      notice = "Slettet redirectionen"
      redirect_to redirections_path, notice: notice
    end

    private

    def redirection_params
      valid_params = params.require(:redirection).
             permit(:urlpath, :headword, :clarification, :article_id)
      valid_params[:urlpath] = nil if valid_params[:urlpath].empty?
      valid_params[:clarification] = nil if valid_params[:clarification].empty?
      valid_params
    end

    def set_redirection
      @redirection = params[:id] ?
        SnlAdmin.redirection_class.find(params[:id]) :
        SnlAdmin.redirection_class.new()
    end

  end
end