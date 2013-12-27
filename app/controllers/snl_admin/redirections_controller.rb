# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class RedirectionsController < ApplicationController
    before_filter :set_redirection
    respond_to :html

    def index
      @redirections = if params[:query]
        term = params[:query].strip
        conditions = "permalink ILIKE ? OR to_permalink ILIKE ?"
        Redirection.where(conditions, "%#{term}%", "%#{term}%").
             order('permalink asc')
      else
        Redirection.order('permalink asc')
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
             permit(:permalink, :to_permalink, :from_encyclopedia_id, :to_encyclopedia_id)
      valid_params
    end

    def set_redirection
      @redirection = params[:id] ?
        SnlAdmin.redirection_class.find(params[:id]) :
        SnlAdmin.redirection_class.new()
    end

  end
end