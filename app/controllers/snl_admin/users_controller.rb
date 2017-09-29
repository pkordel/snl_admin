# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class UsersController < ApplicationController
    before_action :set_user, except: [:index]
    respond_to :html

    def index
      @users = if params[:query]
        term = params[:query].strip
        conditions = "email_address ILIKE ? OR firstname ILIKE ? OR lastname ILIKE ?"
        SnlAdmin.user_class.where(conditions, "%#{term}%", "%#{term}%", "%#{term}%").
                            order('firstname asc')
      else
        SnlAdmin.user_class.order('firstname asc')
      end.page params[:page]
    end

    def show
    end

    def new
      @title = t('new_user')
    end

    def create
      @user = SnlAdmin.user_class.new user_params
      if @user.save
        respond_with @user
      else
        render :new
      end
    end

    def edit
      @title = t('edit_user')
    end

    def update
      if @user.update_attributes user_params
        respond_with @user
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to users_path
    end

    private

    def set_user
      @user = params[:id] ?
        SnlAdmin.user_class.find(params[:id]) :
        SnlAdmin.user_class.new(role: 'contributor')
    end

    def user
      @decorated_user ||= UserPresenter.new(@user, view_context)
    end
    helper_method :user

    def user_params
      params.require(:user).permit(:firstname,
                                   :lastname,
                                   :email_address,
                                   :username,
                                   :role)
    end
  end
end
