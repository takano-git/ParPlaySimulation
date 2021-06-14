class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	# before_action :authenticate_user!

	# ログイン済みのユーザーか確認する。
	def logged_in_user
		unless user_signed_in?
			flash[:danger] = "ログインして下さい。"
			redirect_to root_url
		end
	end

	# 渡されたユーザーがログイン済みのユーザーであればtrueを返す。
	def current_user?(user)
		user == current_user
	end

	# アクセスしたユーザーが現在ログインしているユーザーか確認する。
	def correct_user
		unless current_user?(@user)
			flash[:danger] = "他のユーザーは権限がありません。"
			redirect_to root_url
		end
	end

	# システム管理権限所有かどうか判定する。
	def admin_user
		unless user_signed_in? && current_user.admin?
			flash[:danger] = "管理者権限が必要です。"
			redirect_to root_url
		end
	end

	# 管理権限者、または現在ログインしているユーザーを許可する。
	def admin_or_correct_user
		# @user = User.find(params[:id]) if @user.blank?
		unless current_user?(@user) || current_user.admin?
			flash[:danger] = "権限がありません。"
			redirect_to root_url
		end
	end

	# 会員かどうか判定する。
	def premium_user
		unless user_signed_in? && current_user.premium?
			flash[:danger] = "権限がありません。会員様専用のページです。"
			redirect_to root_url
		end
	end

	private
	
		def no_admin_return
			redirect_to root_path unless current_user.admin?
		end

		def no_logged_in_return
			redirect_to root_path unless user_signed_in?
		end

		def current_user_admin?
			@admin_user = current_user ? current_user.admin? : current_user
		end

end
