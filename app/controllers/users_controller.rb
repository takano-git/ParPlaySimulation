class UsersController < ApplicationController
  before_action :admin_user

  def index
    # @users = User.where(admin: false).order(:id)
    @users = User.page(params[:page]).per(5).where(admin: false).order(:id)
  end
end
