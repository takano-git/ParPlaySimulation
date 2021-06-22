class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  before_action :set_clubs , only: %i[ index chart ]


  def index
  end

  def new
    @club = Club.new
  end

  def create
    @club= Club.new(club_params)
    if @club.save
      flash[:success] = '新しいゴルフクラブを登録しました。'
      redirect_to clubs_url(@user)
    else
      render :edit
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

  private

    def club_params
      params.require(:club).permit(:yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id)
    end

    def set_clubs
      @clubs = Club.where(user_id: @user)
    end
end
