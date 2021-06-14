class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。

  def index
    @clubs = Club.where(user_id: @user)
    #配列形式でデータを用意する
    # @data = Club.where(user_id: @user).pluck(:largo, :weight)

    # @data = [['2019-06-01', 100], ['2019-06-02', 200], ['2019-06-03', 150]](参考)
    # gon.data = []
    # 6.times do
    #   gon.data << rand(100.0)
    # end
    sum = 0
    # gon.bardata = []
    gon.linedata = []
    gon.linedata = Club.where(user_id: @user).pluck(:weight)

    # 6.times do |i|
    #   data = rand(100.0)
    #   gon.bardata << data
    #   sum = sum + data
    #   gon.linedata << sum
    # end
  end

  def new
    @club = Club.new
  end

  def create
    @club= Club.new(club_params)
    if @club.save
      flash[:success] = 'ゴルフクラブを登録しました。'
      redirect_to clubs_url(@user)
    else
      render :edit
    end
  end

  private

    def club_params
      params.require(:club).permit(:yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id)
    end

end
