
class PostsController < ApplicationController

  #@@update_counters = 0

  before_action :find_post, only: [:edit, :update, :destroy, :upvote]
  before_action :authenticate_user!
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    #@posts = Post.where(user_id: current_user.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 6)
    @posts = Post.where(user_id: current_user.id)
    @fake_posts = Fpost.joins(:randomized_fposts).where(randomized_fposts: {user_id: current_user.id}).select("fposts.*, randomized_fposts.fake_time")
    
    @future_fake_posts = @fake_posts.where('fake_time > ?', Time.now)
    @past_fake_posts = @fake_posts.where('fake_time < ?', Time.now)
    @future_and_real_posts = @future_fake_posts + @posts

    @all_posts = @posts + @fake_posts

    #Sort all posts
    @all_posts = @all_posts.sort_by(&:fake_time).reverse
    
    #@all_posts = @all_posts.sort_by(&:fake_time).reverse
    @all_posts = @all_posts.paginate(:page => params[:page], :per_page => 9)

    # Pinned posts
    @pinned_posts = Post.where(user_id: current_user.id, pinned: true)
    @pinned_fposts = Fpost.where(pinned: true, futurepost: false).joins(:randomized_fposts).where(randomized_fposts: {user_id: current_user.id}).select("fposts.*, randomized_fposts.fake_time")
    @pinned = @pinned_posts + @pinned_fposts

    # Sort all pinned posts
    @pinned = @pinned.sort_by(&:fake_time).reverse

    # Random posts
    @random_fposts = @fake_posts.where(futurepost: false).order("RANDOM()").first(9)

    # Update views and likes after each request
    @all_posts.each do |fp|
      fp.update_attributes(lowviews: fp.lowviews + rand(1..3), 
                           highviews: fp.highviews + rand(5..10),
                           lowlikes: fp.lowlikes + rand(0..1),
                           highlikes: fp.highlikes + rand(0..1))
    end
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

  # Upvotes for real and fakeposts
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

  # Views for real and fakeposts
  def view
    @post = Post.find(params[:post_id])
    @post.views.create(user_id: current_user.id)

    views = @post.views.where(user_id: current_user).size + give_num_of_basic_fakeviews(@post)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js {render json: views }
    end
  end

  def fview
    @fpost = Fpost.find(params[:post_id])
    @fpost.fviews.create(user_id: current_user.id)

    views = @fpost.fviews.where(user_id: current_user).size + give_num_of_basic_fakeviews(@fpost)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js {render json: views }
    end
  end

  # Wenn die Futureposts erscheinen, sollen sie 0 likes und 0 views haben!
  def reset_future_posts
    @futureposts = Fpost.where(futurepost: true)
    futureposts_ids = []

    @futureposts.each do |post|
      post.update_attributes( lowviews: 0, 
                              highviews: 0,
                              lowlikes: 0,
                              highlikes: 0)
      futureposts_ids << post.id
    end

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js {render json: futureposts_ids }
    end
  end

  private

  def post_params
    params.require(:post).permit(:pinned, :description, :link, :lowlikes, :highlikes, :time_ago, :picture, :first_time_visited_at, :fake_time, :lowviews, :highviews)
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

  def give_num_of_basic_fakeviews(post)
    num = 0

    if current_user.group == 0 || current_user.group == 2
      num = post.highviews
    else
      num = post.lowviews
    end

    num
  end

end
