class AreasController < ApplicationController
  before_action :admin_user, only: %i(edit update)
  before_action :set_areas_group_by_district, only: %i(index show)

  def index
    @golfclub = Golfclub.where(closed: false).first
    @golfclubs_citys = Golfclub.where(closed: false).pluck(:area_id).uniq.sort
  end

  def show
    # @areas = Area.all.order(:id).group_by(&:district)
    @area = Area.find(params[:id])
    @golfclubs = Golfclub.where(area_id: @area.id, closed: false).order(:id)
    @golfclubs_citys = Golfclub.where(closed: false).pluck(:area_id).uniq.sort
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

    def set_areas_group_by_district
      @areas = Area.all.order(:id).group_by(&:district)
    end

    def areas_params
      params.permit(areas: [:district])[:areas]
    end

end
