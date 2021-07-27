class StrategyInfosController < ApplicationController
  before_action :admin_user, only: %i(destroy)
  before_action :premium_user, only: %i(index new create edit update)

  def index
    @golfclub = Golfclub.find(params[:golfclub_id])
    @golfclub_id = @golfclub.id
    @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)
    @course_id = @courses.first.id
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id).order(:id)
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id], location_name: "R").order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
    # @shot_tee_options = @strategy_shots["tee"].map {
    #   |c| [ c.id, c.shot_id, data: { show_path: golfclub_strategy_infos_path(c.id) }]
    # }
    # byebug
    # 攻略情報があるとき
    if @strategy_info.present?
      # 登録情報はあるが、写真がない場合の処理
      @photo_presence = @strategy_info.photo.attached?
      unless @photo_presence
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @strategy_info.hole_id,
          shot_id: @strategy_info.shot_id, location_name: @strategy_info.location_name).first
      end
    end
  end

  # 攻略情報ページ。コースボタンクリック時のAjaxアクション
  def hole
    @course_id = params[:course_id]
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: params[:course_id]).order(:id)
    @hole = @holes.first
    @strategy_infos = StrategyInfo.where(golfclub_id: params[:golfclub_id], course_id: params[:course_id]).order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: @hole.id).select(:id, :shot_id).group_by(&:shot_id)
    # 攻略情報があるとき
    if @strategy_info.present?
      # 登録情報はあるが、写真がない場合の処理
      @photo_presence = @strategy_info.photo.attached?
      unless @photo_presence
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @strategy_info.hole_id,
          shot_id: @strategy_info.shot_id, location_name: @strategy_info.location_name).first
      end
    end
  end
  
  # 攻略情報ページ。ホールボタンクリック時のAjaxアクション
  def main
    @hole = Hole.find(params[:hole_id])
    @strategy_infos = StrategyInfo.where(
      golfclub_id: params[:golfclub_id], course_id: params[:course_id], 
      hole_id: params[:hole_id], location_name: params[:location_name]
    ).order(:id)
    @strategy_info = @strategy_infos.first
    @strategy_shots = @strategy_infos.where(hole_id: params[:hole_id]).select(:id, :shot_id).group_by(&:shot_id)
    # 攻略情報があるとき
    if @strategy_info.present?
      # 登録情報はあるが、写真がない場合の処理
      @photo_presence = @strategy_info.photo.attached?
      unless @photo_presence
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @strategy_info.hole_id,
          shot_id: @strategy_info.shot_id, location_name: @strategy_info.location_name).first
      end
    end
  end

  # 攻略情報ページ。ロケーション（R,B,G）ボタンクリック時のAjaxアクション
  def location
    # renderの切り替えはstrategy_infos/index_render_files/main
    @hole = Hole.find(params[:hole_id])
    @strategy_infos = StrategyInfo.where(hole_id: params[:hole_id], location_name: params[:location_name]).order(:id)
    @strategy_info = @strategy_infos.first
    # @strategy_infoがblankの時、攻略情報が存在しないview表記(_show.html.erb)
    @strategy_shots = @strategy_infos.where(hole_id: params[:hole_id]).select(:id, :shot_id).group_by(&:shot_id)
    # 攻略情報があるとき
    if @strategy_info.present?
      # 登録情報はあるが、写真がない場合の処理
      @photo_presence = @strategy_info.photo.attached?
      unless @photo_presence
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @strategy_info.hole_id,
          shot_id: @strategy_info.shot_id, location_name: @strategy_info.location_name).first
      end
    end
  end

  # 攻略情報ページ。shotボタンクリック時のAjaxアクション
  def show
    @strategy_info = StrategyInfo.find(params[:id])
    # 攻略情報があるとき
    if @strategy_info.present?
      # 登録情報はあるが、写真がない場合の処理
      @photo_presence = @strategy_info.photo.attached?
      unless @photo_presence
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @strategy_info.hole_id,
          shot_id: @strategy_info.shot_id, location_name: @strategy_info.location_name).first
      end
    end
  end

  # 攻略情報新規作成ページ。コース,ホールそれぞれのselectボックス変更時のAjaxアクション
  # def form_map
  #   location_colums = ["map_r","map_b","map_l"]
  #   @hide_locations = location_colums - ["map_"+params[:location_name].downcase]
  #   if params[:hole_data].blank?
  #     course_id = params[:course_data][:course][:course_id]
  #     @holes = Hole.where(course_id: course_id).order(:id)
  #     @hole = @holes.first
  #     @hole_options = @holes.order(:id).map { 
  #       |c| [c.hole_number, c.id, data: { hole_path: form_map_golfclub_strategy_infos_path(c.golfclub_id) }]
  #     }
  #   else
  #     @hole = Hole.find(params[:hole_data][:hole][:hole_id])
  #   end
  # end

  def registration_edit
    # コースが登録されていなかったらリダイレクト



    # byebug
    @golfclub = Golfclub.find(params[:golfclub_id])
    @area = Area.find(@golfclub.area_id)
    @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)

    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: switch_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    if params[:course_id].blank?
      # ゴルフクラブ一覧ページから来た場合
      @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @courses.first.id).order(:id)
      @hole_options = @holes.map { 
        |c| [c.hole_number, c.id, data: { hole_path: switch_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
      @hole = @holes.first
      # ここからログインユーザー登録情報の有無フラグ
      @strategy_info = StrategyInfo.where(user_id: current_user.id, hole_id: @hole.id,
                                                location_name: "R", shot_id: "tee").first
      @new_or_edit = @strategy_info.blank?
      @strategy_info = StrategyInfo.new if @new_or_edit
    else
      # 攻略情報ページから来た場合
      @course_id = params[:course_id]
      @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @course_id).order(:id)
      @hole_options = @holes.map { 
        |c| [c.hole_number, c.id, data: { hole_path: switch_golfclub_strategy_infos_path(c.golfclub_id) }]
      }
      @hole = Hole.find(params[:hole_id])
      @hole_id = params[:hole_id]
      # ここからログインユーザー登録情報の有無フラグ
      @strategy_info = StrategyInfo.where(user_id: current_user.id, hole_id: @hole_id, location_name: params[:location_name],
                                                shot_id: params[:shot_id]).first
      @new_or_edit = @strategy_info.blank?
      # ログインユーザー登録情報がない場合とphotoの登録がない場合権利者のものを探す
      if @new_or_edit || !@strategy_info.photo.attached?
        @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @hole_id, location_name: params[:location_name],
                                                  shot_id: params[:shot_id]).first
      end
      @strategy_info = StrategyInfo.new if @new_or_edit
      # byebug
    end
    @photo_present = @strategy_info.photo.attached? unless @new_or_edit
    # byebug
  end

  # registration_editでのAjax
  def switch
    @golfclub = Golfclub.find(params[:golfclub_id])
    @courses = Course.where(golfclub_id: params[:golfclub_id]).order(:id)
    @course_options = Course.where(golfclub_id: params[:golfclub_id]).order(:id).map {
      |c| [c.name, c.id, data: { children_path: switch_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    @course_id = params[:course_id]
    @holes = Hole.where(golfclub_id: params[:golfclub_id], course_id: @course_id).order(:id)
    @hole_options = @holes.map { 
      |c| [c.hole_number, c.id, data: { hole_path: switch_golfclub_strategy_infos_path(c.golfclub_id) }]
    }
    # コースに変更があったかどうか
    if @course_id == params[:course_first] # なかった場合
      @hole = Hole.find(params[:hole_id])
      @hole_id = params[:hole_id]
    else #あった場合
      @hole = Hole.where(course_id: @course_id).first
      @hole_id = @hole.id
    end
    # ホールのマップが登録されてなかった時の処理

    # byebug

    # 
    # ここからログインユーザー登録情報の有無フラグ
    @strategy_info = StrategyInfo.where(user_id: current_user.id, hole_id: @hole_id, 
                                        location_name: params[:location_name], shot_id: params[:shot_id]).first
    @new_or_edit = @strategy_info.blank? #trueでnew
    # byebug
    unless @new_or_edit
      @photo_present = @strategy_info.photo.attached?
      unless @photo_present
      # [編集]ログインユーザーの登録情報写真がない場合権利者レコードを探す
      @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @hole_id,
        location_name: params[:location_name],
        shot_id: params[:shot_id]).first unless current_user.admin?
      end
    else
      # [新規]ログインユーザーの登録情報がない場合権利者レコードを探す
      @strategy_info_admin = StrategyInfo.where(user_id: 1, hole_id: @hole_id,
                                                location_name: params[:location_name],
                                                shot_id: params[:shot_id]).first unless current_user.admin?
    end
    @strategy_info = StrategyInfo.new if @new_or_edit
    @location_name = params[:location_name] if @new_or_edit
    # byebug
  end

  def new
    # どのviewから飛んできたかどうかで場合分け？
    # ゴルフクラブIDはどちらからでも取れている。
    # →indexページで選択されている、course_id, hole_id, shot_id, location_name, 座標カラムを渡す。 
    # byebug
    @strategy_info_admiin = StrategyInfo.find(params[:id]) if params[:id].present?
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
    @strategy_info = StrategyInfo.new(strategy_info_params)
    if @strategy_info.save
      flash[:success] = "攻略情報を登録しました。"
    else
      flash[:danger] = @strategy_info.errors.full_messages.join("<br>").html_safe
    end
  end

  def edit
    @strategy_info = StrategyInfo.find(params[:id])
  end

  def update
    @strategy_info = StrategyInfo.find(params[:id])
    if @strategy_info.update(strategy_info_params)
      respond_to do |format|
        format.js { flash.now[:success] = "攻略情報を編集しました。" }
      end
    else
      respond_to do |format|
        format.js { flash.now[:danger] = "編集に失敗しました。" }
      end
    end
  end

  def destroy
    @strategy_info = StrategyInfo.find(params[:id])
    @strategy_info.photo.perge if @strategy_info.photo.attached? 
    @strategy_info.destroy
  end

  private

    def strategy_info_params
      params.permit(:user_id, :golfclub_id, :course_id, :hole_id, :shot_id, :location_name, :photo, :comment,
                     :photo_target_x, :photo_target_y, :photo_point_x, :photo_point_y, :photo_size_x, :photo_size_y,
                     :map_target_x, :map_target_y, :map_point_x, :map_point_y, :map_shoot_x, :map_shoot_y, :map_size_x, :map_size_y)
    end
end