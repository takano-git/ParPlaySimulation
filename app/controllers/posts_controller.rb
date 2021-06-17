class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: %i(edit update destroy)
  before_action :authenticate_user!
  before_action :user_signed_in?

  def index
    @q = @user.posts.ransack(params[:q])
    @user_posts = @q.result(distinct: true)
    @categories = Post.all.pluck(:category_id).uniq.sort
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_url(@user), flash: { success: "タイトル: #{@post.title} を投稿しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_posts_url(@user), flash: { success: "タイトル: #{@post.title} を更新しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join("<br>").html_safe
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_url(@user), flash: { success: "タイトル: #{@post.title} を削除しました。" }
  end

  private

    def set_user
      @user = current_user
    end

    def set_post
      @post = @user.posts.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :comment, :user_id, :golfclub_id, :category_id, :photo)
    end
end
