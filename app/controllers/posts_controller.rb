
class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy, :upvote]
  before_action :authenticate_user!
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(user_id: current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    @fposts = Fpost.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    @allposts = @posts + @fposts
    @pinned_posts = Post.where(user_id: current_user.id, pinned: true).order("created_at DESC")
    @pinned_fposts = Fpost.where(pinned: true).order("created_at DESC")
    @pinned = @pinned_posts + @pinned_fposts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Dein Beitrag wurde erfolgreich gespeichert."
    else
      render 'new', notice: "Leider konnte dein Beitrag nicht gespeichert werden."
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Dein Beitrag wurde aktualisiert."
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def upvote
    @post.likes.create(user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  def fupvote
    @fpost = Fpost.find(params[:id])
    @fpost.flikes.create(user_id: current_user.id)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:pinned, :description, :link, :lowlikes, :highlikes, :time_ago, :picture)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_owner
    unless @post.user_id == current_user.id 
      flash[:notice] = "Tut mir Leid, aber du kannst nur deine eigenen Beiträge editieren."
      redirect_to posts_path
    end
  end
end
