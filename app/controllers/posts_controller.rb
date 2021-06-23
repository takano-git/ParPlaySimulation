class PostsController < ApplicationController
  before_action :premium_user, only: %i(index show new create edit update destroy)
  before_action :set_user
  before_action :set_golfclub, only: %i(index new create edit update)
  before_action :set_post, only: %i(edit update destroy)
  before_action :authenticate_user!
  before_action :user_signed_in?
  before_action :post_limitation, only: %i(edit update destroy)

  def index
    @search = Post.where(golfclub_id: @golfclub.id).ransack(params[:search])
    @posts = @search.result(distinct: true)
    @categories = Post.all.pluck(:category_id).uniq.sort
  end

  # def show
  # end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to golfclub_posts_url, flash: { success: "タイトル: #{@post.title} を投稿しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to golfclub_posts_url, flash: { success: "タイトル: #{@post.title} を更新しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @post.photo.purge if @post.photo.attached?
    @post.destroy
    redirect_to golfclub_posts_url, flash: { success: "タイトル: #{@post.title} を削除しました。" }
  end

  private

    def set_user
      @user = current_user
    end

    def set_golfclub
      @golfclub = Golfclub.find(params[:golfclub_id])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :comment, :user_id, :golfclub_id, :category_id, :photo)
    end
    
    # 自分以外の投稿のアクセス制限
    def post_limitation
      @post = Post.find(params[:id])
      unless @post.user_id. == @current_user.id
        redirect_to golfclub_posts_url
      end
    end
end
