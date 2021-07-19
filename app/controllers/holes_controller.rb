class HolesController < ApplicationController

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @course = Course.find(params[:course_id])
    # @course = golfclub.courses
  end
end
