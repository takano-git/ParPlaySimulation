class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: %i(edit destroy)
  before_action :admin_return
  before_action :set_user
  before_action :correct_user

  # GET /cards or /cards.json
  def index
    # @customer = Payjp::Customer.retrieve(current_user.customer_id)
    # @cards = @customer.cards.all

    @card = Card.find_by(user_id: current_user.id, default_card: true) if Card.where(user_id: current_user.id).present?
    # すでにクレジットカードが登録しているか？
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      # PAY.JPから顧客情報を取得する。
      @customer = Payjp::Customer.retrieve(@card.customer_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      # @card_info = customer.cards.retrieve(customer.default_card)
      @cards_info = @customer.cards.all
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの有効期限を取得
      # @exp_month = @card_info.exp_month.to_s
      # @exp_year = @card_info.exp_year.to_s.slice(2,3) 

    end
  end

  # GET /cards/1 or /cards/1.json
  # def show
  # end

  # GET /cards/new
  def new
    # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    @card = Card.new
    # @card = Card.where(user_id: current_user.id).first
    # redirect_to action: "index" if @card.present?
  end

  # GET /cards/1/edit
  # def edit
  # end

  # POST /cards or /cards.json
  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    if params['payjp-token'].blank?
      # トークンが取得出来てなければループ
      flash[:danger] = 'カード情報を登録できませんでした。'
      redirect_to action: "new"
    else
      #--- 登録済みのカードが存在するか確認する。 ---#
      # 登録済みのカードが存在した場合（カードの追加）
      if  Card.where(user_id: current_user.id).present?
        # default_card = Card.find_by(user_id: current_user.id, default_card: true)
        # params['payjp-token']（response.id）からcustomerを作成
      #  customer = Payjp::Customer.retrieve(default_card.customer_id)
        pj_customer = Payjp::Customer.retrieve(current_user.customer_id)
        # metadata: {user_id: current_user.id}
        pj_card = pj_customer.cards.create(card: params["payjp-token"])
        @default_card = Card.find_by(default_card: true)
        @default_card.update(default_card: false)
        @card = Card.new(
          user_id: current_user.id,
          customer_id: pj_customer.id,
          card_id: pj_card.id,
          default_card: true
        )
        if @card.save
          flash[:success] = '新規カードを登録しました.'
          redirect_to cards_path
        else
          flash[:danger] = '新規カードを登録できませんでした。'
          redirect_to action: "new"
        end
     
      # 登録済みのカードが存在しなかった場合（新規作成）
      else
        # params['payjp-token']（response.id）からcustomerを作成
        customer = Payjp::Customer.create(
          card: params['payjp-token']
        # metadata: {user_id: current_user.id}
        )
        # debugger
        @card = Card.new(
          user_id: current_user.id,
          customer_id: customer.id,
          card_id: customer.default_card,
          default_card: true
        )
        if @card.save
          # カード情報を保存できたらpayアクションを呼び出し、サブスクリプションの作成とユーザー情報の更新を行う。
          pay
          flash[:success] = '会員登録ありがとうございます.'
          redirect_to cards_path
        else
          flash[:danger] = 'カード情報を登録できませんでした。'
          redirect_to action: "new"
        end
      end
      
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  # def update
  #   respond_to do |format|
  #     if @card.update(card_params)
  #       format.html { redirect_to @card, notice: "Card was successfully updated." }
  #       format.json { render :show, status: :ok, location: @card }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @card.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    # @card.destroy
    # respond_to do |format|
    #   format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
    #   format.json { head :no_content }
    # end
    # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりcreateメソッドが複雑にならない。
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    # PAY.JPの顧客情報を取得

    customer = Payjp::Customer.retrieve(@card.customer_id)
    # customer.delete # PAY.JPの顧客情報を削除
    # debugger
    if @card.destroy # App上でもクレジットカードを削除
      current_user.update(payment_id: nil, customer_id: nil, membership_number: nil, subscription_id: nil, premium: false)
      flash[:success] = 'カード情報を削除しました。'
      redirect_to action: "index"
    else
      flash[:danger] = 'カード情報を削除できませんでした。'
      redirect_to action: "index"
    end
  end

  def about
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      # @card = Card.find(params[:id])
      @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.fetch(:card, {})
    end

    # 支払い情報の作成
    def pay
      # card = Card.where(user_id: current_user.id).last
      card = Card.find_by(user_id: current_user.id, default_card: true)
      # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      subscription = Payjp::Subscription.create(
        :customer => card.customer_id,
        :plan => plan, # planアクションで定義した情報を呼び出す
        metadata: {current_id: current_user.id}
      )
      # Userテーブルのsubscription_idに値を持たせ、premiumカラムをtrueにして、current_user情報をアップデート
      # membership_number = "PSP" + sprintf("%05d", current_user.id)
      max = User.where(premium: true).maximum(:membership_number)
      if max.nil?
        membership_number = 1
      else
        membership_number = max + 1
      end
      current_user.update(payment_id: card.id, customer_id: card.customer_id, membership_number: membership_number, subscription_id: subscription.id, premium: true)
    end
  
    # 定期課金プランの作成
    def plan
      # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      # Payjp::Plan.all
      # if params['payjp-token'].blank?
        Payjp::Plan.create(
        # pj_plan = Payjp::Plan.create(
          :name => "Par Play Simulation",
          :amount => 980,
          :interval => 'month',
          :currency => 'jpy',
          # :trial_days => 30,
        )
      # end
    end

end
