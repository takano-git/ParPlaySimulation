class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  before_action :set_clubs , only: %i[ index select chart ]


  def index
    @selected_clubs = SelectedClub.all
  end

  def select
    @selected_clubs = SelectedClub.all
  end

  def add
    selected_club = SelectedClub.new
    selected_club.user_id = params[:id] 
    selected_club.club_id = params[:selected_club]

    if selected_club.save
      #head 201
      club = Club.find(selected_club.club_id)
      hash = {id: club.id, detail: club.detail}
      require 'json'
      render :json => hash.to_json
    else
      head 500
    end

  end

  def new
    @club = Club.new
  end

  def create
    @club= Club.new(club_params)
    if @club.save
      flash[:success] = '新しいマイクラブを登録しました。'
      redirect_to clubs_url(@user)
    else
      # render :edit
      # redirect_to :new
      # flash[:danger] = @club.errors.full_messages.join("<br>").html_safe
      # render :new
      # render json: { status: 'error'}
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

  private

    def club_params
      params.require(:club).permit(:yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id)
    end

    def set_clubs
      @clubs = Club.where(user_id: @user)
    end
end
