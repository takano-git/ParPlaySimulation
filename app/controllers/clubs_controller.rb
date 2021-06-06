class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。

  def new
    @user = current_user
    @club = Club.new
  end

  def create
    # @user = User.find(params [:user_id])
    @club= Club.new(club_params)
    if @club.save
      flash[:success] = 'ゴルフクラブを登録しました。'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

    def club_params
      params.require(:club).permit(:yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id)
    end

end
