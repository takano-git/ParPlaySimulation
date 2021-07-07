class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  before_action :set_clubs , only: %i[ index select chart ]


  def index
  end

  def select
    @selected_clubs = current_user.clubs.where(selected: true)
  end

  def add
    club = Club.find(params[:selected_club])
    selected_clubs = current_user.clubs.where(selected: true).count
    
    if selected_clubs >= 14
      flash[:danger] = 'クラブセッティングは14本までです。'
      redirect_to clubs_select_user_path(@user)
    elsif club.selected == true
      flash[:danger] = 'すでにクラブセッティングに入っています。'
      redirect_to clubs_select_user_path(@user)
    else
      club.selected = true
      if club.save
        #head 201
        flash[:success] = 'クラブセッティングを１本追加しました。'
        hash = {id: club.id, detail: club.detail}
        require 'json'
        render :json => hash.to_json
      else
        head 500
      end
    end


  end

  def new
    @club = Club.new
  end

  def create
    @club= Club.new(club_params)

    # ユーザー毎のゴルフクラブのカウンターを計算し@club.counterに代入
      # ゴルフクラブ登録が初めてなら
    if current_user.clubs.count == 0
      @club.counter = 1
      # ゴルフクラブ登録が1本以上あれば
    elsif current_user.clubs.count > 0
      @club.counter = current_user.clubs.all.pluck(:counter).max + 1
    end

    if @club.save
      flash[:success] = '新しいマイクラブを登録しました。'
      redirect_to clubs_url(@user)
    else
      redirect_to clubs_path
      flash[:danger] = @club.errors.full_messages.join('。').html_safe
    end
  end

  # ゴルフクラブチャート表示
  def chart
    largo_weight_data = [] # 配列[[長さ, 重さ],[長さ, 重さ], ...]
    scatterdata = [] # 散布図表示用データ配列
  
    largo_weight_data = Club.where(user_id: @user).pluck(:largo, :weight)
    largo_weight_data.each do |data|
      scatterdata.push({ x: data[0], y: data[1] })
    end
    gon.scatterdata = scatterdata  # jsに渡す散布図表示用データ配列
  end

  # ゴルフクラブ論理削除
  def logical_deletion

    club = Club.find(params[:id])
    club.deleted_at = Time.now
    if club.save
      flash[:success] = 'ゴルフクラブを削除しました。'
      redirect_to clubs_url(@user)
    else
      flash[:danger] = 'ゴルフクラブの削除に失敗しました。'
      redirect_to clubs_url(@user)
    end
  end

  private

    def club_params
      params.require(:club).permit(:yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id, :selected, :deleted_at)
    end

    def set_clubs
      # @clubs = Club.where(user_id: current_user)
      @clubs = current_user.clubs.all
    end
end
