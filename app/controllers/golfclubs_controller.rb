class GolfclubsController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)

  def index
    @golfclubs = Golfclub.all    
  end

  def new
    @golfclub = Golfclub.new
    golfclub = @golfclub.courses.build
    golfclub.holes.build
  end

  def create
    redirect_to new_golfclub_url
  end

  def edit
  end

  def update
  end

  def destroy
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
