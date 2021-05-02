class CardsController < ApplicationController
  require 'payjp'
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
    
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]

    debugger
    customer = Payjp::Customer.create(
      card: params[:card_token],
      # card: params[:authenticity_token],
      # card: params['payjp-token'],
      metadata: {user_id: current_user.id}
    )
    
    @card = Card.new(
      card_id: customer.default_card,
      customer_id: customer.id,
      user_id: current_user.id
    )
    if @card.save
      flash[:success] = "会員情報の登録に成功しました。"
      redirect_to golfclub_index_path
    else
      flash[:danger] = "会員情報の登録に失敗しました。"
      render :new
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
end
