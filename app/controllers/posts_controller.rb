
class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy, :upvote]
  before_action :authenticate_user!
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    #@posts = Post.where(user_id: current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    @posts = Post.where(user_id: current_user.id)
    @fake_posts = Fpost.all
    @all_posts = @posts + @fake_posts
    
    # Wie ändere ich die Reihenfolge der Fakeposts zufällig?
    #   1) @fake_posts.to_a.shuffle   ???
    #   2) Mit normalen Posts in @all_posts zusammenfügen
    #   3) 

    #Sort all posts
    @all_posts = @all_posts.sort_by(&:created_at).reverse
    @all_posts = @all_posts.paginate(:page => params[:page], :per_page => 6)

    # Pinned posts
    @pinned_posts = Post.where(user_id: current_user.id, pinned: true)
    @pinned_fposts = Fpost.where(pinned: true)
    @pinned = @pinned_posts + @pinned_fposts

    # Sort all pinned posts
    @pinned = @pinned.sort_by(&:created_at).reverse
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
    params.require(:post).permit(:pinned, :description, :link, :lowlikes, :highlikes, :time_ago, :picture, :first_time_visited_at)
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
