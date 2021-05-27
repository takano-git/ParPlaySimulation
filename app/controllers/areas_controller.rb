class AreasController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)
  before_action :set_area, only: :show

  def index
    @areas = Area.all.order(:id).group_by(&:district)
  end

  def show
    area_ids = []
    golfclubs = []

    areas = Area.where(district: @area.district)
    areas.each do|area|
      area_ids = area_ids.push(area.id)
    end
  
    area_ids.each do|area_id|
      golfclubs = golfclubs.push(Golfclub.find_by(id: area_id))
    end
    @golfclubs = golfclubs.compact
  
    


    # Golfclub.where(area_id: 2)
  end

  def edit
    @areas = Area.all.order(:id)
  end

  def update
    areas_params.each do |id, area_param|
      area= Area.find(id)
      area.update_attributes!(area_param)
    end
    flash[:success] = "地域を更新しました。"
    redirect_to areas_url
  rescue
    flash[:danger] = "無効な入力があった為、更新がキャンセルされました。"
    redirect_to edit_areas_url
  end

  private

    def set_area
      @area = Area.find(params[:id])
    end

    def areas_params
      params.permit(areas: [:district])[:areas]
    end
@toshihiro-mabuchi

end
