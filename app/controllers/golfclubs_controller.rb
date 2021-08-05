class GolfclubsController < ApplicationController
  before_action :admin_user
  before_action :set_golfclub, only: %i(show edit update destroy)

  def index
    @q = Golfclub.ransack(params[:q])
    @golfclubs = @q.result(distinct: true).page(params[:page]).per(25).order(:id)
    @areas = Area.all.index_by(&:id)
    @courses = Course.all.group_by(&:golfclub_id)
  end

  def show
    @courses = @golfclub.courses.order(:id)
  end

  def new
    @golfclub = Golfclub.new
    @courses = @golfclub.courses.build
  end

  def create
    @golfclub = Golfclub.new(golfclub_params)
    if @golfclub.save
      redirect_to golfclub_url(@golfclub), flash: { success: "#{@golfclub.name}を登録しました。" }
    else
      redirect_to golfclubs_url, flash: { danger: @golfclub.errors.full_messages.join }
    end
  end

  def edit
  end

  def update
    if @golfclub.update(golfclub_params)
      redirect_to golfclubs_url, flash: { success: "#{@golfclub.name}を更新しました。" }
    else
      redirect_to golfclubs_url, flash: { danger: @golfclub.errors.full_messages.join }
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      if @golfclub.destroy!
        @golfclub.photo.purge if @golfclub.photo.attached?
        redirect_to golfclubs_url, flash: { success: "#{@golfclub.name}を削除しました。" }
      end
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to golfclubs_url, flash: { danger: "【#{@golfclub.name}】は攻略、投稿情報へ使用されています。削除できません。" }
  end

  private

    def set_golfclub
      @golfclub = Golfclub.find(params[:id])
    end

    def golfclub_params
      params.require(:golfclub).permit(:name, :home_page_url, :strategy_video, :area_id, :closed, :photo)
    end
end
