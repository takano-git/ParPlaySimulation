class AreasController < ApplicationController
  # before_action 管理者のみアクセス可能にする(あとで設定)

  def index
    @areas = Area.all.order(:id).group_by(&:district) # 13地区でグループ化された47都道府県

    @golfclub = Golfclub.first
    # @prefectures = Area.all # 47都道府県のインスタンス
    # # golfclub_of_prefecture = [[prefecture, ゴルフ場の数],[prefecture, ゴルフ場の数],[prefecture, ゴルフ場の数]]
    # golfclubs_per_prefecture = [] #[[prefecture, golfclubs],[prefecture, golfclubs], ...]

    # @prefectures.values.each do |prefecture|
    #   golfclubs = Golfclub.where(area_id: id) #その件に登録されているゴルフ場のインスタンスを取得 []
    #   golfclubs_per_prefecture = [].push([prefecture, golfclubs]) #["北海道" ,[]]
    # end

    # @golfclubs_per_prefecture = golfclubs_per_prefecture

  end

  def show
    @areas = Area.all.order(:id).group_by(&:district)
    @area = Area.find(params[:id])
    @golfclubs = Golfclub.where(area_id: @area.id)
  end

  def edit
    @areas = Area.all.order(:id)
  end

  def update
    areas_params.each do |id, area_param|
      area= Area.find(id)
      area.update_attributes!(area_param)
    end
    flash[:info] = "地域を更新しました。"
    redirect_to areas_url
  rescue
    flash[:danger] = "無効な入力があった為、更新がキャンセルされました。"
    redirect_to edit_areas_url
  end

  private

    def areas_params
      params.permit(areas: [:district])[:areas]
    end
end
