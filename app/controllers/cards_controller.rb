class CardsController < ApplicationController
  require 'payjp'
  # before_action :set_card, only: %i(edit destroy)
  before_action :set_card, only: %i(update destroy)
  before_action :admin_return
  before_action :set_user
  before_action :correct_user

  # カード一覧の表示
  def index
    @cards = current_user.cards.all.order(:id)

    #-- PSY.JPのカード情報を使用するパターン（未使用） --#
    # すでにクレジットカードが登録しているか？
    # if @cards.present?
    #   # 登録している場合,PAY.JPからカード情報を取得する
    #   # PAY.JPの秘密鍵をセットする。
    #   Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    #   # PAY.JPから顧客情報を取得する。
    #   customer = Payjp::Customer.retrieve(@card.customer_id)
    #   # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
    #   @cards_info = customer.cards.all
    # end

  end

  # GET /cards/1 or /cards/1.json
  # def show
  # end

  # カードの登録画面表示
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  # def edit
  # end

  # カードの作成処理
  def create
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報を取得する。
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    # トークンが取得出来てなければループ
    if params['payjp-token'].blank?
      flash[:danger] = 'カード情報を登録できませんでした。'
      redirect_to action: "new"
    else
      #--- ここですでにPayjpのCard情報は、作成されている。---#
      #--- 登録済みのカードが存在するか確認する。 ---#
      #--- 登録済みのカードが存在した場合（カードの追加）---#
      if  Card.where(user_id: current_user.id).present?
        # PayjpのCustomer情報を取得する。
        pj_customer = Payjp::Customer.retrieve(current_user.customer_id)
        # Payjpの新しいカード情報を作成する。
        pj_card = pj_customer.cards.create(card: params["payjp-token"])
        # 新しく登録したカード情報で、Cardモデルのデフォルトカードを作成する。
        card = Card.new(
          user_id: current_user.id,
          customer_id: pj_customer.id,
          card_id: pj_card.id,
          brand: pj_card.brand,
          exp_month: pj_card.exp_month,
          exp_year: pj_card.exp_year,
          last4: pj_card.last4,
          # default_card: true
        )
        if card.save
          flash[:success] = '新規カードを登録しました.'
          redirect_to cards_path
        else
          flash[:danger] = '新規カードを登録できませんでした。'
          redirect_to action: "new"
        end
      #--- 登録済みのカードが存在しなかった場合（新規作成）---#
      else
        # params['payjp-token']（response.id）からPayjpのCustomerを作成する。
        pj_customer = Payjp::Customer.create(
          card: params['payjp-token'],
          metadata: {user_id: current_user.id}
        )
        # 上記で作成したPayjpのCustomerを読み込む（customer_idを取得するため）。
        pj_card = pj_customer.cards.data.find.first
        # Cardモデルに新規のカード情報を作成する。
        card = Card.new(
          user_id: current_user.id,
          customer_id: pj_customer.id,
          card_id: pj_card.id,
          brand: pj_card.brand,
          exp_month: pj_card.exp_month,
          exp_year: pj_card.exp_year,
          last4: pj_card.last4,
          default_card: true
        )
        if card.save
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

  # 支払いカード変更
  def update
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報を取得する。
    # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    customer = Payjp::Customer.retrieve(current_user.customer_id)
    customer.default_card = @card.card_id
    customer.save
    default_card = current_user.cards.find_by(default_card: true)
    if default_card != nil
      default_card.update(default_card: false)
    end
    @card.update(default_card: true)
    if current_user.premium?
      current_user.update(payment_id: @card.id)
    else
      max = User.where(premium: true).maximum(:membership_number)
      if max.nil?
        membership_number = 1
      else
        membership_number = max + 1
      end
      current_user.update(payment_id: @card.id, customer_id: @card.customer_id, membership_number: membership_number, premium: true)
    end
    flash[:success] = "支払いカードを変更しました。"
    redirect_to action: "index"
  end

  # カードの削除処理
  def destroy
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報を取得する。
    # Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    # 削除するカードがデフォルトカードだったら、PAY.JPの支払い情報（定期課金）とカード情報を削除して、
    # ユーザーを会員から退会させる。
    customer = Payjp::Customer.retrieve(@card.customer_id)
    card = customer.cards.retrieve(@card.card_id)
    card.delete
    if @card.default_card?
      # current_user.update(payment_id: nil, customer_id: nil, membership_number: nil, subscription_id: nil, premium: false)
      current_user.update(payment_id: nil, membership_number: nil, premium: false)
    end
    # App上でもクレジットカードを削除する。
    if @card.destroy
      # カードが存在しなくなったら、PAY.JPの顧客情報と支払い情報を削除して、ユーザー情報を更新する。
      if Card.where(user_id: current_user.id).blank?
        customer = Payjp::Customer.retrieve(@card.customer_id)
        customer.delete
        # subscription = Payjp::Subscription.retrieve(current_user.subscription_id)
        # subscription.delete
        current_user.update(customer_id: nil, subscription_id: nil)
      end
      flash[:success] = 'カード情報を削除しました。'
      redirect_to action: "index"
    else
      flash[:danger] = 'カード情報を削除できませんでした。'
      redirect_to action: "index"
    end
  end

  # カード裏面の番号とは？
  def about
  end


  private

    # カード情報の設定
    def set_card
      @card = current_user.cards.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.fetch(:card, {})
    end

    # 支払い情報の作成
    def pay
      card = Card.find_by(user_id: current_user.id, default_card: true)
      subscription = Payjp::Subscription.create(
        :customer => card.customer_id,
        # planアクションで定義した情報をセットする。
        :plan => plan,
        metadata: {current_id: current_user.id}
      )
      # Planテーブルが存在しなかった場合、Planテーブルを作成する。
      if Plan.first == nil
        Plan.create(name: "スタンダードプラン", plan_id: subscription.plan.id)
      end
      # Userテーブルをアップデートする。
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
      if Plan.first != nil
        Payjp::Plan.retrieve(Plan.first.plan_id)
      else
        Payjp::Plan.create(
          :name => "Par Play Simulation",
          :amount => 980,
          :interval => 'month',
          :currency => 'jpy',
          # :trial_days => 30,
        )
      end
    end

end
