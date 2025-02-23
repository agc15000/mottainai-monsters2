class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # ログイン必須
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index #ユーザーのすべての投稿がタイムライン形式で表示されるように後で設定
    @posts = Post.includes(:user).order(created_at: :desc)#最新の投稿の順番
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿が作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿が更新されました"
    else
      render :edit
    end
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

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user #自身の投稿のみ編集、破棄が可能
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
