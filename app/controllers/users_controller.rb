class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :only_see_own_page, only: [:show]

  def show
    begin
      @user = User.find(params[:id])
      @fakeposts = Fpost.joins(:randomized_fposts).where(randomized_fposts: {user_id: @user.id}).select("fposts.*, randomized_fposts.fake_time")
      @posts = @user.posts
      @pinned_posts = @posts.where(pinned: true)
    
      @liked_posts = @posts.joins(:likes).where(likes: {user_id: @user.id })
      @liked_fakeposts = @fakeposts.joins(:flikes).where(flikes: {user_id: @user.id }).select("fposts.*, randomized_fposts.fake_time") 

      @liked_allposts = @liked_posts + @liked_fakeposts
      @liked_allposts = @liked_allposts.sort_by(&:fake_time)

      #@liked_fakeposts = @liked_fakeposts.sort_by(&:fake_time)

      @likes = @user.flikes + @user.likes

    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end

  private

  def only_see_own_page
    @user = User.find(params[:id])

    if current_user != @user
      redirect_to root_path, notice: "Tut mir Leid, aber du hast keinen Zugang auf die Seite."
    end
  end
end
