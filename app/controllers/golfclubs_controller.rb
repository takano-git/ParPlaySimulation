class GolfclubsController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)
  before_action :set_golfclub, only: %i(destroy)

  def index
    @golfclubs = Golfclub.all
  end

  def new
    @golfclub = Golfclub.new
    golfclub = @golfclub.courses.build
    golfclub.holes.build
  end

  def create
    @golfclub = Golfclub.new(golfclub_params)
    if @golfclub.save
      redirect_to new_golfclub_url, flash: {success: "登録が完了しました"}
    else
      flash[:danger] = @golfclub.errors.full_messages.join
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @golfclub.destroy
    flash[:danger] = "削除"
    redirect_to golfclubs_url
  end

  private

    def set_golfclub
      @golfclub = Golfclub.find(params[:id])
    end

    def golfclub_params
      params.require(:golfclub).permit(:name,
                                       :home_page_url,
                                       :strategy_video,
                                       :golfclub_id,
                                       :course_id,
                                       courses_attributes:
                                       [
                                         :name,
                                         :golfclub_id
                                       ],
                                       holes_attributes:
                                       [
                                         :hole_number,
                                         :number_of_pars,
                                         :golfclub_id,
                                         :course_id
                                       ]
                                      )
    end
end
