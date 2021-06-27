class CoursesController < ApplicationController
  # before_action :premim_user, only: %i(new create edit update)
  before_action :admin_user
  before_action :set_golfclub, only: %i(new create edit update)
  before_action :set_course, only: %i(edit update)
  before_action :set_pars, only: %i(new create edit update)

  # 入力フォームのパー数(名前空間を切ってmoduleをfreezeして定数の書き換えを防ぐ)
  module ParConstant
    PARS = [3, 4, 5, 6, 7].map(&:freeze).freeze
  end
  ParConstant.freeze

  def new
    @course = Course.new
    9.times {|n| @course.holes.build(hole_number: n + 1, number_of_pars: 3 ) }
  end

  def create
    @course = @golfclub.courses.build(course_params)
    if @course.save
      redirect_to golfclub_url(@golfclub), flash: { success: "コース【#{@course.name}】を登録しました。" }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to golfclub_url(@golfclub), flash: { success: "コース【#{@course.name}】を編集しました。" }
    else
      render :edit
    end
  end

  # def destroy
  #   @course.destroy
  #   redirect_to golfclub_url(@golfclub), flash: { success: "コース【#{@course.name}】を削除しました。" }
  # end

  private

    def set_golfclub
      @golfclub = Golfclub.find(params[:golfclub_id])
    end

    def set_course
      @course = @golfclub.courses.find_by(id: params[:id])
    end
    
    # holes_attributes: [:id ...] ここに:idを渡してないとupdateした時、ホール情報が新たに重複登録されてしまう。
    def course_params
      params.require(:course).permit(:name, holes_attributes: [:id, :hole_number, :number_of_pars, :golfclub_id, :course_id])
    end

    def set_pars
      @pars = ParConstant::PARS
    end
end
