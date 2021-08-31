class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  before_action :set_clubs , only: %i[ index select ]
  before_action :premium_user # 有料会員のみ
  before_action :check_setting_clubs , only: %i[ add_form ] # セッティングが14本より多くチェックされていたらリダイレクト

  # マイクラブ一覧
  def index
  end

  # クラブセッティングに加えるselectページ表示機能
  def select
    # 長い順にクラブセッティングに選ばれたクラブを並び替え
    @selected_clubs = current_user.clubs.where(selected: true).order(largo: :DESC)
  end

  # クラブセッティングに加える機能
  def add_form
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      clubs_params.each do |id, item|
        club = Club.find(id)
        club.update_attributes!(item)
      end
    end
    flash[:success] = "クラブセッティングを更新しました。"
    redirect_to clubs_select_user_path(@user)
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力があった為、クラブセッティングの更新をキャンセルしました。"
    redirect_to clubs_select_user_path(@user)
  end

  # セッティングから外す機能
  def take
    @club = Club.find(params[:id])
    @club.selected = false
    if @club.save
      redirect_to clubs_select_user_path(@user), flash: { success: "#{@club.yarn_count_string}#{@club.yarn_count_number}をクラブセッティングから外しました。" }
    else
      redirect_to clubs_select_user_path(@user), flash: { danger: "#{@club.yarn_count_string}#{@club.yarn_count_number}をクラブセッティングから外す処理に失敗しました。" }
    end
  end

  # ゴルフクラブ新規登録画面
  def new
    @club = Club.new
  end

  # ゴルフクラブ新規登録機能
  def create
    @club= Club.new(club_params)

    if @club.save
      flash[:success] = '新しいマイクラブを登録しました。'
      redirect_to clubs_url(@user)
    else
      redirect_to clubs_path
      flash[:danger] = @club.errors.full_messages.join('。').html_safe
    end
  end

  # ゴルフクラブ編集画面
  def edit
    @club = Club.find_by(user_id: current_user, id: params[:id])
  end

  # ゴルフクラブ更新
  def update
    @club = Club.find_by(user_id: current_user, id: params[:id])

    if @club.update(club_params)
      redirect_to clubs_url(@user), flash: { success: "ゴルフクラブ【#{@club.yarn_count_string}#{@club.yarn_count_number}】を編集しました。" }
    else
      redirect_to clubs_url(@user), flash: { danger: @club.errors.full_messages.join }
    end
  end

  # ゴルフクラブチャート表示ページ
  def chart
    largo_weight_data = [] # 配列[[長さ, 重さ],[長さ, 重さ], ...]
    scatterdata = [] # 散布図表示用データ配列
  
    @selected_clubs = current_user.clubs.where(selected: true).order(largo: :DESC)
    largo_weight_data = @selected_clubs.pluck(:largo, :weight)

    largo_weight_data.each do |data|
      scatterdata.push({ x: data[0], y: data[1] })
    end
    gon.scatterdata = scatterdata  # jsに渡す散布図表示用データ配列
  end

  # ゴルフクラブ論理削除
  def logical_deletion
    club = Club.find(params[:id])
    if club.delete_flg.blank?
     club.delete_flg = true
    else
      club.delete_flg = nil
    end

    if club.save
      redirect_to clubs_url(@user)
      flash[:success] = 'ゴルフクラブを変更しました。'
    else
      flash[:danger] = 'ゴルフクラブの変更に失敗しました。'
      redirect_to clubs_url(@user)
    end
  end

  private
    def clubs_params
      params.require(:user).permit(clubs: [:selected, :id])[:clubs]
    end

    def club_params
      params.require(:club).permit(:id, :yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id, :selected, :delete_flg)
    end

    def set_clubs
      @clubs = current_user.clubs.all.order(largo: :DESC)
    end

    # ゴルフクラブセッティングが14本より多くチェックされていたらリダイレクト
    def check_setting_clubs
      selected_club_ids = []
      clubs_params.each do |id, item|
        if item[:selected] == "1"
          id = id.to_s
          selected_club_ids.push(id)
        end
      end
      if selected_club_ids.count > 14
        flash[:danger] = "クラブセッティングは14本までです。"
        redirect_to clubs_select_user_path(@user)
      end
    end

end
