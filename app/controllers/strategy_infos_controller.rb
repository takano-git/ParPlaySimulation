class StrategyInfosController < ApplicationController

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @golfclub_id = @golfclub.id
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @course_id = @courses.first.id
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id)
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id], location_name: "R")
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
  end

  # 攻略情報ページ。コースボタンクリック時のAjaxアクション
  def hole
    @golfclub_id = params[:golfclub_id]
    @course_id = params[:course_id]
    @holes = Hole.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id]
    )
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
  end
  
  # 攻略情報ページ。ホールボタンクリック時のAjaxアクション
  def main
    @hole = Hole.find(params[:hole_id])
    location_colums = ["map_r","map_b","map_l"]
    @p_loca = [params[:location]]
    @hide_locations = location_colums - ["map_"+params[:location]]
    @strategy_infos = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id], 
      hole_id: params[:hole_id], location_name: params[:location].upcase
    )
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: params[:hole_id]).select(:id, :shot_id).group_by(&:shot_id)
  end

  # 攻略情報ページ。shotボタンクリック時のAjaxアクション
  def show
    @strategy_info = StrategyInfo.find(params[:id])
  end


  def new
    @golfclub = Golfclub.find(params[:golfclub_id])
    @area = Area.find(@golfclub.area_id)
    @courses = Course.where(golfclub_id: params[:golfclub_id])
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id)
    @hole = @holes.first
    @strategy_info = StrategyInfo.new
    @hole_options = @holes.order(:id).map { 
      |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
  end

  # 攻略情報新規作成ページ。コース,ホールそれぞれのselectボックス変更時のAjaxアクション
  def form_map
    location_colums = ["map_r","map_b","map_l"]
    @hide_locations = location_colums - ["map_"+params[:location_name].downcase]
    if params[:hole_data].blank?
      course_id = params[:course_data][:course][:course_id]
      @holes = Hole.where(course_id: course_id)
      @hole = @holes.first
      @hole_options = @holes.order(:id).map { 
        |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
    else
      @hole = Hole.find(params[:hole_data][:hole][:hole_id])
    end
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