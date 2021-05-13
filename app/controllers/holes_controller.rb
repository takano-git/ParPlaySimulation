class HolesController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)

  # def index
  #   @holes = Hole.all
  # end

  def new
    @pars = [3, 4, 5, 6, 7]
    @form = Form::HoleCollection.new
  end

  def create
    @form = Form::HoleCollection.new(hole_collection_params)
    flash[:success] = "テスト#{@form}"
    redirect_to new_golfclub_course_hole_path
    # debugger
    # if @form.save
    #   redirect_to new_golfclub_course_hole_path
    # else
    #   render :new
    # end
  end

  private

    def hole_collection_params
      params
      .require(:form_hole_collection)
      .permit(holes_attributes: [:hole_number, :number_of_pars, :golfclub_id, :course_id])
    end

  # def new
  #   @golfclub = Golfclub.find(params[:golfclub_id])
  #   @course = Course.find(params[:course_id])
  #   @hole = @course.holes.build
  # end

  # def create
  #   redirect_to new_golfclub_course_hole_path
  # end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end
end
