class StrategyPhotosController < ApplicationController
  before_action :admin_user

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @courses = Course.where(golfclub_id: params[:golfclub_id]).pluck(:id, :name)
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: golfclub_strategy_photos_path(c.golfclub_id) }]
    }
    @holes = Hole.where(golfclub_id: params[:golfclub_id]).pluck(:id, :hole_number)
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id]).with_attached_photo
    .order(:course_id, :hole_id, :location_name, :shot_id).page(params[:page]).per(36)
    # .page(params[:page]).per(36)
    user_ids = @strategy_infos.pluck(:user_id).sort.uniq
    @users = User.find(user_ids).pluck(:id, :nickname)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def course
    @golfclub = Golfclub.find(params[:golfclub_id])
    @courses = Course.where(golfclub_id: params[:golfclub_id]).pluck(:id, :name)
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: golfclub_strategy_photos_path(c.golfclub_id) }]
    }
    @course_id = params[:course_id]
    @holes = Hole.where(course_id: params[:course_id]).pluck(:id, :hole_number)
    @strategy_infos = StrategyInfo.where(course_id: params[:course_id]).with_attached_photo
    .order(:course_id, :hole_id, :location_name, :shot_id).page(params[:page]).per(36)
    user_ids = @strategy_infos.pluck(:user_id).sort.uniq
    @users = User.find(user_ids).pluck(:id, :nickname)
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