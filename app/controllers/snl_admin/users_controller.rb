# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class UsersController < ApplicationController
    before_filter :set_user
    respond_to :html

    def index
      @users = User.order('firstname asc')
    end

    def show
    end

    def new
      @title = t('new_user')
    end

    def create
      @user = User.new user_params
      @user.skip_confirmation! if params[:confirmed]
      if @user.save
        @user.confirm! if params[:confirmed]
        redirect_to users_path
      else
        render :new
      end
    end

    def edit
      @title = t('edit_user')
    end

    def update
      if @user.update_attributes user_params
        @user.confirm! if params[:confirmed]
        redirect_to users_path
      else
        render :edit
      end
    end

    def destroy
      if @user.id == current_user.id
        notice = "Din egen bruker '#{@user.public_name}' kan ikke slettes av deg selv."
        redirect_to users_path, notice: notice and return
      end

      if ::Authorship.where("user_id = ?", @user.id).count > 1
        notice = "Brukeren '#{@user.public_name}' og dens personlige side kunne \
                  ikke slettes, fordi brukeren har bidratt med leksikonartikler."
         redirect_to users_path, notice: notice and return
      end

      if ::Version.where("created_by_id = ?", @user.id).count > 1
        notice = "Brukeren '#{@user.public_name}' kan ikke slettes fordi \
                  brukeren har lagt inn forbedrinsgforslag i leksikonet."
        redirect_to users_path, notice: notice and return
      end

      if ::Version.where("evaluated_by_id = ?", @user.id).count > 1
        notice = "Brukeren '#{@user.public_name}' kan ikke slettes fordi brukeren har \
                  evaluert forbedrinsgforslag i leksikonet."
        redirect_to users_path, notice: notice and return
      end

      if delete_user
        notice = "Brukeren '#{@user.public_name}' og dens personlige side ble \
                  slettet. Brukerens personlige side er heller ikke søkbar lenger."
        redirect_to users_path, notice: notice and return
      end
    end

    private

    def set_user
      @user = params[:id] ? User.find(params[:id]) : User.new
    end

    def user_params
      params.require(:user).
             permit(:firstname, :lastname, :email_address, :role,
                    :mobilenumber, :license_id, :email_notifications,
                    :fixed_ceiling, :activated, :postal_address,
                    :password, :confirmed)
    end

    def delete_user
      article_id = @user.article_id
      @user.article_id = nil
      @user.save!
      Article.find(article_id).remove(@user)
      @user.destroy
    end
  end
end
