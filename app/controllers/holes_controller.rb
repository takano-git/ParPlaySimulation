class HolesController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)
  before_action :set_golfclub, only: %i(create)
  # before_action :set_course, only: %i(create)

  # def index
  #   @holes = Hole.all
  # end

  def new
    @hole = Hole.new
    # @course = Course.find(params[:course_id])
    # @hole_collection = Form::HoleCollection.new
    @pars = [3, 4, 5, 6, 7]
    @out = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def create
    @pars = [3, 4, 5, 6, 7]
    @course = Course.find(params[:course_id])
    # @hole = @course.holes.build(hole_params)
    # @hole_collection = @golfclub_course.holes.build(hole_collection_params)
    @hole = @golfclub.courses.find(params[:course_id]).holes.build(hole_params)
    if @hole.save
      redirect_to golfclub_path(@golfclub), flash: { success: "ホールを登録しました。" }
    else
      flash.now[:alert] = @hole.errors.full_messages.join
      render :new
    end
  end

  private

    # def hole_collection_params
    #   params.require(:form_hole_collection).permit(holes_attributes: [:hole_number, :number_of_pars, :golfclub_id, :course_id])
    # end

    def hole_params
      params.require(:hole).permit(:hole_number, :number_of_pars, :golfclub_id, :course_id)
    end

    def set_golfclub
      @golfclub = Golfclub.find(params[:golfclub_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # def golfclub_course_params
    #   params.require(:golfclub).permit(:name, :home_page_url, :strategy_video, :area_id, courses_attributes:[:name, :golfclub_id,])
    # end
end
