# -*- encoding : utf-8 -*-
require_dependency "snl_admin/application_controller"

module SnlAdmin
  class UsersController < ApplicationController
    before_filter :set_user
    respond_to :html

    def index
      @users = if params[:query]
        term = params[:query].strip
        conditions = "username ILIKE ? OR firstname ILIKE ? OR lastname ILIKE ?"
        User.where(conditions, "%#{term}%", "%#{term}%", "%#{term}%").
             order('firstname asc')
      else
        User.order('firstname asc')
      end.page params[:page]
    end

    def show
      @user = UserPresenter.new(@user)
    end

    def new
      @title = t('new_user')
    end

    def create
      @user = SnlAdmin.user_class.new user_params
      @user.skip_confirmation! if params[:confirmed]
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
        @user.confirm! if params[:confirmed] && !@user.confirmed?
        respond_with @user
      else
        render :edit
      end
    end

    def destroy
      if delete_user
        notice = "Brukeren '#{@user.public_name}' og dens personlige side ble \
                  slettet. Brukerens personlige side er heller ikke søkbar lenger."
        redirect_to users_path, notice: notice
      end
    end

    def reset_statistics
      @user.reset_statistics
      notice = if @user.save!
        "Statistikk for brukeren '#{@user.public_name}' ble slettet"
      else
        "Statistikk for brukeren '#{@user.public_name}' ble ikke slettet"
      end
      redirect_to @user, notice: notice
    end

    private

    def set_user
      @user = params[:id] ?
        SnlAdmin.user_class.find(params[:id]) :
        SnlAdmin.user_class.new(role: 'contributor')
    end

    def user_params
      params.require(:user).
             permit(:firstname, :lastname, :email_address, :username, :role,
                    :mobilenumber, :license_id, :email_notifications,
                    :fixed_ceiling, :activated, :postal_address,
                    :password, :confirmed, :institution_code, :paid_to_date)
    end

    def delete_user
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

      article_id = @user.article_id
      @user.update_attribute(:article_id, nil)
      Article.find(article_id).remove(@user)
      @user.destroy
    end
  end
end
