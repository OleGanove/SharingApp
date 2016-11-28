
class PostsController < ApplicationController
  # Hier noch before_action authenticate_user? 
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 9)
    @pinned_posts = Post.where(pinned: true).order("created_at DESC")
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


  private

  def post_params
    params.require(:post).permit(:pinned, :description, :link)
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
