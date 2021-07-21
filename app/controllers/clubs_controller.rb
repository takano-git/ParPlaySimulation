class ClubsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ許可
  before_action :set_user # current_userを@userにセット
  before_action :correct_user # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  before_action :set_clubs , only: %i[ index select ]


  def index
  end

  # クラブセッティングに加えるselectページ
  def select
    # 長い順にクラブセッティングに選ばれたクラブを並び替え
    @selected_clubs = current_user.clubs.where(selected: true).order(largo: :DESC)
  end

  # 選択ボタンを押しクラブセッティングに加える機能
  def add_buttom
    @club = Club.find(params[:id])
    selected_clubs = current_user.clubs.where(selected: true).count
    
    if selected_clubs >= 14
      flash[:danger] = 'クラブセッティングは14本までです。'
      redirect_to clubs_select_user_path(@user)
    elsif @club.selected == true
      redirect_to clubs_select_user_path(@user), flash: { danger: "#{@club.yarn_count_string}#{@club.yarn_count_number}はすでにクラブセッティングに入っています。" }
    else
      @club.selected = true
      if @club.save
        flash[:success] = 'クラブセッティングを１本追加しました。'
        redirect_to clubs_select_user_path(@user)
      else
        flash[:danger] = 'クラブセッティング追加に失敗しました。'
        redirect_to clubs_select_user_path(@user)        
      end
    end
  end


  # ドロップアンドドラッグしクラブセッティングに加える機能
  def add
    @club = Club.find(params[:selected_club])
    selected_clubs = current_user.clubs.where(selected: true).count
    
    if selected_clubs >= 14
      flash[:danger] = 'クラブセッティングは14本までです。'
      redirect_to clubs_select_user_path(@user)
    elsif @club.selected == true
      redirect_to clubs_select_user_path(@user), flash: { danger: "#{@club.yarn_count_string}#{@club.yarn_count_number}はすでにクラブセッティングに入っています。" }
    else
      @club.selected = true
      if @club.save
        #head 201
        flash[:success] = 'クラブセッティングを１本追加しました。'
        redirect_to clubs_select_user_path(@user)
      else
        flash[:denger] = 'クラブセッティング追加に失敗にました。'
        redirect_to clubs_select_user_path(@user)
      end
    end
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

  def new
    @club = Club.new
  end

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

  def edit
    @club = Club.find_by(user_id: current_user, id: params[:id])
  end

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

    def club_params
      params.require(:club).permit(:id, :yarn_count_string, :yarn_count_number, :detail, :loft, :largo, :weight, :balance_string, :balance_number, :frequency, :user_id, :selected, :delete_flg)
    end

    def set_clubs
      @clubs = current_user.clubs.all.order(largo: :DESC)
    end
end
