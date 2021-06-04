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
    @strategy_info = StrategyInfo.where(golfclub_id: params[:golfclub_id]).first
    # byebug
  end

  def hole
    @golfclub_id = params[:golfclub_id]
    @course_id = Course.find(params[:course_id]).id
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @hole = @holes.first
    @strategy_info = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    ).first
    # byebug
  end

  def location
    @location_name = parames[:location_name]
  end
  
  def main 
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @strategy_info = StrategyInfo.where(
      golfclub_id: params[:golfclub_id]
    ).first
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