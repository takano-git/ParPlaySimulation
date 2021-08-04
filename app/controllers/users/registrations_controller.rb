# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # prepend_before_action :require_no_authentication, only: :cancel
  prepend_before_action :authenticate_scope!, only: %i(update destroy)
  prepend_before_action :set_minimum_password_length, only: %i(new edit)
  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update
  before_action :signed_in?, only: %i(create)
  before_action :editable?, only: %i(edit update)

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:danger] = 'パスワードが一致していません。'
      redirect_to new_user_registration_path
    else
      if user = User.find_by(email: params[:user][:email])
        flash[:danger] = '同じメールアドレスが存在します。'
        redirect_to new_user_registration_path
      else
        user = User.new(user_params)
        if user.save
          sign_in user
          flash[:notice] = 'アカウントの登録に成功しました。'
          redirect_to areas_path
        else
          flash[:danger] = 'アカウントの登録に失敗しました。' + user.errors.full_messages.join("<br>")
          redirect_to new_user_registration_path
        end
      end
    end
  end

  # GET /resource/edit
  def edit
    self.resource = resource_class.to_adapter.get!(current_user.id)
  end

  # PUT /resource
  def update
    user = User.find(current_user.id)
    if user.update(update_params)
      flash[:notice] = 'アカウントの変更に成功しました。'
      redirect_to areas_path
    else
      flash[:danger] = 'アカウントの変更に失敗しました。' + user.errors.full_messages.join("<br>")
      redirect_to edit_user_registration_path
    end
  end

  # DELETE /resource
  def destroy
    user = User.find(current_user.id)
    if current_user.cards.size != 0
      flash[:notice] = 'カード情報が登録されています。カード情報を削除して下さい。'
      redirect_to edit_user_registration_path
    else
      if user.destroy
        flash[:notice] = 'アカウントの削除に成功しました。'
        redirect_to root_path
      else
        flash[:notice] = 'アカウントの削除に失敗しました。'
        redirect_to edit_user_registration_path
      end
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

    def user_params
      params.require(:user)
        .permit(:email, :password, :password_confirmation, :name, :nickname, :phone_number, :flying_distance)
    end

    def update_params
      params.require(:user)
        .permit(:name, :nickname, :phone_number, :flying_distance)
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


  # beforeフィルター

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def by_admin_user?(params)
    params[:id].present? && current_user_is_admin?
  end

  def current_user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def sign_up(resource_name, resource)
    if !current_user_is_admin?
      sign_in(resource_name, resource)
    end
  end

  def update_resource_without_password(resource, params)
    resource.update_without_password(params)
  end

  def signed_in?
    if user_signed_in?
      flash[:danger] = "すでにログインされています。"
      redirect_to root_path
    end
  end

  def editable?
    if !user_signed_in?
      flash[:danger] = "ログインされていません。"
      redirect_to root_path
    elsif params[:id].present? && !current_user_is_admin?
      flash[:danger] = "ログインして下さい。"
      redirect_to root_path
    end
  end

end
