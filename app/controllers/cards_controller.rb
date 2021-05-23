class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: %i[ show edit update destroy ]
  # before_action :

  # GET /cards or /cards.json
  # def index
  #   @cards = Card.all
  # end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

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
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
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
      current_user.update(subscription_id: subscription.id, premium: true)
      flash[:danger] = '定期課金に登録できました'
      redirect_to golfclubs_path
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
