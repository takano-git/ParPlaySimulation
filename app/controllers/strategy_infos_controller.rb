class StrategyInfosController < ApplicationController
  before_action :admin_user, only: %i(destroy)
  before_action :premium_user, only: %i(index new create edit update)

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @golfclub_id = @golfclub.id
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @course_id = @courses.first.id
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: @courses.first.id
    )
    @hole = @holes.first
    @strategy_info = StrategyInfo.where(golfclub_id: params[:golfclub_id]).first
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
  end


  def new
    @strategy_info = StrategyInfo.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    # strategy_info.photo.perge
    # strategy_info.hole_map.perge
    
  end
end