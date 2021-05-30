class StrategyInfosController < ApplicationController

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: @courses.first.id
    )
    @hole = Hole.where(golfclub_id: params[:golfclub_id]).first
    @strategy_info = StrategyInfo.where(golfclub_id: params[:golfclub_id]).first
    # byebug
  end

  def hole
    # byebug
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @strategy_info = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    ).first
    # byebug
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