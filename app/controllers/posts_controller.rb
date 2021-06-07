class PostsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :user_signed_in?

  def index
    # @posts = @user.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_url(@user), flash: { success: "新規投稿を登録しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join
      render :new
    end
  end

  def edit
    @post = @user.posts.find_by(id: params[:id])
  end

  def update
    @post = @user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to user_posts_url(@user), flash: { success: "投稿を修正しました。" }
    else
      flash[:danger] = @post.errors.full_messages.join
      render :edit
    end
  end

  private

    def set_user
      @user = current_user
    end

    def post_params
      params.require(:post).permit(:title, :comment, :user_id, :golfclub_id, :category_id, :photo)
    end
end
