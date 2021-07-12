class CategoriesController < ApplicationController
  before_action :admin_user, only: %i(index new create edit update destroy)
  before_action :set_category, only: %i(edit update destroy)

  def index
    @categories = Category.all.order(:id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url, flash: { success: "カテゴリー【#{@category.name}】を登録しました。" }
    else
      redirect_to categories_url, flash: { danger: @category.errors.full_messages.join }
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url, flash: { success: "カテゴリー【#{@category.name}】を更新しました。" }
    else
      redirect_to categories_url, flash: { danger: @category.errors.full_messages.join }
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, flash: { success: "【#{@category.name}】を削除しました。" }
  rescue ActiveRecord::InvalidForeignKey
    redirect_to categories_path, flash: { danger: "【#{@category.name}】は投稿情報へ使用されています。削除できません。" }
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
