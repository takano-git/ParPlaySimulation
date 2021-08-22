class StrategyPhotosController < ApplicationController
  before_action :admin_user

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @courses = Course.where(golfclub_id: params[:golfclub_id]).pluck(:id, :name)
    @holes = Hole.where(golfclub_id: params[:golfclub_id]).pluck(:id, :hole_number)
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id]).page(params[:page]).per(36)
    .order(:course_id, :hole_id, :location_name, :shot_id)
    # @users = @q.page(params[:page]).per(16).where(admin: false).order(:id)
    # byebug
    user_ids = @strategy_infos.pluck(:user_id).sort.uniq
    @users = User.find(user_ids).pluck(:id, :nickname)
  end

  def all_photos
  end

  def course
  end

  def destroy
    @strategy_info = StrategyInfo.find(params[:id])
    if !current_user.admin?
      flash[:danger] = "管理者以外は他人の攻略情報を削除できません。"
      redirect_to action: :index and return
    end
    ActiveRecord::Base.transaction do
      if @strategy_info.destroy!
        @strategy_info.photo.purge if @strategy_info.photo.attached?
        flash[:success] = "#{params[:status]}の攻略情報を削除しました。" 
        redirect_to action: :index
      end
    end
    rescue ActiveRecord::InvalidForeignKey
    flash[:danger] = "削除できません。"
    redirect_to action: :index
  end

end