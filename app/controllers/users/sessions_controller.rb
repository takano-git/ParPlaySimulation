# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # super
    if user = User.find_by(email: params[:user][:email])
      if user.valid_password?(params[:user][:password])
        sign_in user
        flash[:notice] = "ログインに成功しました。"
        if user.admin?
          redirect_to admin_pages_path
        else
          redirect_to golfclub_index_path
        end
      else
        flash[:danger] = "パスワードが違います。ログインをやり直して下さい。"
        redirect_to new_user_session_path
      end
    else
      flash[:danger] = "名前が見つかりませんでした。ログインをやり直して下さい。" 
      redirect_to new_user_session_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
