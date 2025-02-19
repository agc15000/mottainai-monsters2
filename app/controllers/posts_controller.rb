class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # ログイン必須

  def index #ユーザーのすべての投稿がタイムライン形式で表示されるように後で設定
    @posts = Post.includes(:user).order(created_at: :desc)#最新の投稿の順番
  end

  def new
    @post = Post.new
  end

  def create
    current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notion: "投稿が作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit #後で設定

  end

  def update #後で設定

  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id]) #ここのparamsはどのような動きをしている？要確認
    if @post
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました"
    else
      redirect_to posts_path, alert: "削除できませんでした"
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
