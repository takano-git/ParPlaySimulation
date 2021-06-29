class StrategyInfosController < ApplicationController
  before_action :admin_user, only: %i(destroy)
  before_action :premium_user, only: %i(index new create edit update)

  def index
    # new,editから飛んできた場合の処理(before_action)
    # 新規登録、編集した攻略情報のcourse,hole,shot,location_nameの攻略情報を表示

    # -----------------------------------
    @golfclub = Golfclub.find(params[:golfclub_id])
    @golfclub_id = @golfclub.id
    @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)
    @course_id = @courses.first.id
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id).order(:id)
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id], location_name: "R").order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
  end

  # 攻略情報ページ。コースボタンクリック時のAjaxアクション
  def hole
    @course_id = params[:course_id]
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: params[:course_id]).order(:id)
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id], course_id: params[:course_id]).order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
  end
  
  # 攻略情報ページ。ホールボタンクリック時のAjaxアクション
  def main
    @hole = Hole.find(params[:hole_id])
    location_colums = ["map_r","map_b","map_l"]
    @hide_locations = location_colums - ["map_"+params[:location]]
    @strategy_infos = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id], 
      hole_id: params[:hole_id], location_name: params[:location].upcase
    ).order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: params[:hole_id]).select(:id, :shot_id).group_by(&:shot_id)
  end

  # 攻略情報ページ。ロケーション（R,B,G）ボタンクリック時のAjaxアクション
  def location
    location_colums = ["map_r","map_b","map_l"]
    @hide_locations = location_colums - ["map_"+params[:location_name].downcase]
    # renderの切り替えはstrategy_infos/index_render_files/main
    # 1つのホール情報とホールの攻略情報があればよい
    # マップの表示切替はjsで設定してある。
    @hole = Hole.find(params[:hole_id])
    @strategy_infos = StrategyInfo.where(hole_id: params[:hole_id], location_name: params[:location_name]).order(:id)
    if @strategy_infos.blank?
      # エラーメッセージ＆redirect

    else

    end
    @strategy_info = @strategy_infos.first
    # @strategy_infoがblankの時、攻略情報が存在しないview表記(_show.html.erb)
    # 全てのrender時に攻略情報が存在するかどうかチェックし_showのレンダー
    @strategy_shots = @strategy_infos.where(hole_id: params[:hole_id]).select(:id, :shot_id).group_by(&:shot_id)
    # byebug
  end

  # 攻略情報ページ。shotボタンクリック時のAjaxアクション
  def show
    @strategy_info = StrategyInfo.find(params[:id])
  end

  # 攻略情報新規作成ページ。コース,ホールそれぞれのselectボックス変更時のAjaxアクション
  def form_map
    location_colums = ["map_r","map_b","map_l"]
    @hide_locations = location_colums - ["map_"+params[:location_name].downcase]
    if params[:hole_data].blank?
      course_id = params[:course_data][:course][:course_id]
      @holes = Hole.where(course_id: course_id).order(:id)
      @hole = @holes.first
      @hole_options = @holes.order(:id).map { 
        |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
    else
      @hole = Hole.find(params[:hole_data][:hole][:hole_id])
    end
  end
  
  # newかeditどちらなのか判定するアクション
  def Judge
  end

  def registration_edit
    byebug
    # @golfclubと@areaは確定
    @golfclub = Golfclub.find(params[:golfclub_id])
    @area = Area.find(@golfclub.area_id)
    # パラメータからゴルフクラブ一覧ページ、攻略情報ページのどちらから飛んできたか判断
    # ゴルフクラブ一覧から来た場合、(攻略情報ページのぱらめーたがない)
    if params[:strategy_info_id].blank?
      # params[:golfclub_id]の
      # @courses, course_idの最も小さい@holes,
      # hole_idの最も小さい@strategy_info取得 → edit
      # @stratwgy_infoがないとき
        # @strategy_info = StrategyInfo.new → new
  
      @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)
      @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
        |c| [c.name, c.id, data: { children_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
      @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id).order(:id)
      @hole = @holes.first
      @strategy_info = StrategyInfo.new
      @hole_options = @holes.order(:id).map { 
        |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
    else
    # 攻略情報ページから来た場合、
      # パラメータの本人データがあるか確認
      # （couse,hole,location,shotとuser_idチェック）
      # ある場合
        # それらのデータを変数に格納 → edit
      # ない場合
        # 江草さんのデータを探す
        # ある場合
          # @strategy_info_eg = えぐささんのデータ
          # ,@strategy_info = StrategyInfo.new → new
        # ない場合
          #  → new
    end
    # 
    # (例)usersコントローラーのshowアクションにid=1を渡す
      redirect_to  controller: :users, action: :show, id: 1

  end

  def new
    # どのviewから飛んできたかどうかで場合分け？
    # ゴルフクラブIDはどちらからでも取れている。
    # →indexページで選択されている、course_id, hole_id, shot_id, location_name, 座標カラムを渡す。 
    # byebug
    @strategy_info_index = StrategyInfo.find(params[:id]) if params[:id].present?
    # viewでstrategy_info_indexの有無で表示切替

    @golfclub = Golfclub.find(params[:golfclub_id])
    @area = Area.find(@golfclub.area_id)

    @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id).order(:id)
    @hole = @holes.first
    @strategy_info = StrategyInfo.new
    @hole_options = @holes.order(:id).map { 
      |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
  end

  def create
    # byebug
    @strategy_info = StrategyInfo.new(strategy_info_params)
    if @strategy_info.save
      flash[:success] = "#{}を登録しました。"
    else
      flash[:danger] = @strategy_info.errors.full_messages.join("<br>").html_safe
    end
    redirect_to action: :new
  end

  def edit
    @strategy_info = StrategyInfo.find(params[:id])
  end

  def update
    # byebug
  end

  def destroy
    # strategy_info.photo.perge
    # strategy_info.hole_map.perge
    
  end

  private

    

    def strategy_info_params
      params.require(:strategy_info)
             .permit(:user_id, :golfclub_id, :course_id, :hole_id, :shot_id, :location_name, :comment,
                     :photo_target_x, :photo_target_y, :photo_point_x, :photo_point_y, :photo_size_x, :photo_size_y,
                     :map_target_x, :map_target_y, :map_point_x, :map_point_y, :map_shoot_x, :map_shoot_y, :map_size_x, :map_size_y)
    end
end