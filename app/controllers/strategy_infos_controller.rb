class StrategyInfosController < ApplicationController

  def index
    # @strategy_infos = StrategyInfo.where(course_id: 1)
    # (仮の変数)
    @strategy_info = StrategyInfo.find(1)
    @hole = Hole.where(course_id: 1).first

    # 選択中コースの攻略情報一覧
    # ユーザーごとにグループを分ける？
    # @strategy_infos = StrategyInfo.where(course_id: params[:course_id]).group_by

    # @hole = Hole.where(golfclub_id: 1)
    # @hole = Hole.where(golfclub_id: 1).first
    # @hole = holes[0]
    # holes.each do |hole, l|
    #   break if l = 1

    # end
  end

  def show 
    # @courses = Course.find(params[:id])
    # @strategy_infos = StrategyInfo.fiind(params[:id])
    # (仮の変数)
    @strategy_info = StrategyInfo.find(1)
    @hole = Hole.where(course_id: 1).first
  end

  def main 
    @strategy_info = StrategyInfo.find(1)
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