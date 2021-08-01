class UsersController < ApplicationController
  before_action :admin_user

  def index
    # @users = User.where(admin: false).order(:id)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(25).where(admin: false).order(:id)
  end
end
