class CategoriesController < ApplicationController
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
      flash[:success] = "カテゴリー【#{@category.name}】を登録しました。"
      redirect_to categories_url
    else
      flash[:danger] = @category.errors.full_messages.join
      render :new
    end
  end

  def edit
  end

  def update
    @category_updated_at = @category.updated_at
    if @category.update(category_params)
      if @category_updated_at != @category.updated_at
        flash[:success] = "カテゴリー【#{@category.name}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to categories_url
    else
      flash[:danger] = @category.errors.full_messages.join
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "カテゴリー【#{@category.name}】を削除しました。"
    redirect_to categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
