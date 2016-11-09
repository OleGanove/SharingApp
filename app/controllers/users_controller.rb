class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    begin
      @user = User.find(params[:id])
      @posts = @user.posts
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end
end
