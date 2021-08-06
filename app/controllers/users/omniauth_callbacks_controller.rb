# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # callback for google
  def google_oauth2
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      if user.delete_flag?
        flash[:danger] = "このユーザーは削除済です。"
        redirect_to root_path
        return
      else
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in user
        redirect_to areas_path, event: :authentication
      end
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      flash[:alert] = user.errors.full_messages.join("\n")
      redirect_to new_user_registration_url
    end
  end
  
end
