class StrategyInfosController < ApplicationController

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @golfclub_id = @golfclub.id
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @course_id = @courses.first.id
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: @courses.first.id
    )
    @hole = @holes.first
    @strategy_info = StrategyInfo.where(golfclub_id: params[:golfclub_id], location_name: "R").first
    # byebug
  end

  def hole
    @golfclub_id = params[:golfclub_id]
    @course_id = params[:course_id]
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @hole = @holes.first
    @strategy_info = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    ).first
    # byebug
  end
  
  def main 
    # byebug
    # @holes = Hole.where(
    #   golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    # )
    @hole = Hole.find(params[:hole_id])
    location_colums = ["map_r","map_b","map_l"]
    @p_loca = [params[:location]]
    @hide_locations = location_colums - ["map_"+params[:location]]
    @strategy_infos = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id], 
      hole_id: params[:hole_id], 
      location_name: params[:location].upcase
    )
    @strategy_info = @strategy_infos.first
    # byebug
  end

  def show
    # byebug
  end


  def new
    # @hole_id = params[:hole_id]
    @golfclub = Golfclub.find(params[:golfclub_id])
    @area = Area.find(@golfclub.area_id)
    # @courses = Course.where(golfclub_id: params[:golfclub_id]).pluck(:id, :name).transpose
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    # @holes = Hole.where(params[:golfclub_id])
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id)
    @hole = @holes.first
    @strategy_info = StrategyInfo.new
    @hole_options = @holes.order(:id).map { 
      |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    # byebug
  end

  def form_map
    # byebug
    if params[:hole_data].blank?
      course_id = params[:course_data][:course][:course_id]
      @holes = Hole.where(course_id: course_id)
      @hole = @holes.first
      @hole_options = @holes.order(:id).map { 
        |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
    else
      # course_id = params[:hole_data][:hole][:course_id]
      # hole_id = params[:hole_data][:hole][:hole_id]
      @hole = Hole.find(params[:hole_data][:hole][:hole_id])
      # byebug
    end
    # render json: @holes.select(:id, :hole_number)
  end

  def create
    # byebug
  end

  def edit
  end

  def update
    # byebug
  end

  def destroy
    # strategy_info.photo.perge
    # strategy_info.hole_map.perge
    
  end

    # def strategy_info_params
    #   params.require(:book).permit(:commtent)
    # end
end