class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: %i(index show destroy)
  # before_action :

  # GET /cards or /cards.json
  def index
    # @cards = Card.all
    # すでにクレジットカードが登録しているか？
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      # PAY.JPから顧客情報を取得する。
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      @card_info = customer.cards.retrieve(customer.default_card)
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの画像を表示するために、カード会社を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 

      # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      # when "JCB"
      #   @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      # when "American Express"
      #   @card_image = "american_express.svg"
      # when "Diners Club"
      #   @card_image = "dinersclub.svg"
      # when "Discover"
      #   @card_image = "discover.svg"
      end
    end 
  end

  # GET /cards/1 or /cards/1.json
  # def show
  # end

  # GET /cards/new
  def new
    # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    # @card = Card.new
    @card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?
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
      user_id = current_user.id
      # params['payjp-token']（response.id）からcustomerを作成
      customer = Payjp::Customer.create(
        card: params['payjp-token']
        # metadata: {user_id: current_user.id}
      )
      @card = Card.new(
        user_id: user_id,
        customer_id: customer.id,
        card_id: customer.default_card
      )
      if @card.save
         # カード情報を保存できたらpayアクションを呼び出す。
        pay
      else
        flash[:danger] = 'カード情報を登録できませんでした。'
        redirect_to action: "new"
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
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      current_user.update(payment_id: nil, membership_number: nil, subscription_id: nil, premium: false)
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

    def pay
      card = Card.where(user_id: current_user.id).last
      # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      subscription = Payjp::Subscription.create(
      :customer => card.customer_id,
      :plan => plan, # planアクションで定義した情報を呼び出す
      metadata: {current_id: current_user.id}
      )
      # Userテーブルのsubscription_idに値を持たせ、premiumカラムをtrueにして、current_user情報をアップデート
      membership_number = "PSP" + sprintf("%05d", card.id)
      current_user.update(payment_id: card.id, membership_number: membership_number, subscription_id: subscription.id, premium: true)
      flash[:success] = '定期課金にご登録ありがとうございます.'
      redirect_to cards_path
    end
  
    # 定期課金プラン
    def plan
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      Payjp::Plan.create(
        :name => "Par Play Simulation",
        :amount => 980,
        :interval => 'month',
        :currency => 'jpy',
      )
    end

end
