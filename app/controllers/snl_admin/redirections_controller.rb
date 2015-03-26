# -*- encoding : utf-8 -*-
require_dependency 'snl_admin/application_controller'

module SnlAdmin
  class RedirectionsController < ApplicationController
    before_filter :set_redirection, except: [:index]
    respond_to :html

    def index
      @redirections = if params[:query]
                        term = params[:query].strip
                        conditions = 'permalink ILIKE ? OR to_permalink ILIKE ?'
                        SnlAdmin.redirection_class
                        .where(conditions, "%#{term}%", "%#{term}%")
                      else
                        SnlAdmin.redirection_class
                      end.order('permalink asc').page params[:page]
    end

    def new
      @title = t('new_redirection')
    end

    def edit
      @title = t('edit_redirection')
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
      notice = t('destroy_redirection')
      redirect_to redirections_path, notice: notice
    end

    private

    def redirection_params
      params.require(:redirection).permit(:permalink,
                                          :to_permalink,
                                          :from_encyclopedia_id,
                                          :to_encyclopedia_id,
                                          :state)
    end

    def set_redirection
      @redirection = if params[:id].present?
                       SnlAdmin.redirection_class.find(params[:id])
                     else
                       SnlAdmin.redirection_class.new
                     end
    end

    attr_reader :redirection
    helper_method :redirection
  end
end
