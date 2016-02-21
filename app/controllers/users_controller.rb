class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    puts @user.shared_unwatched_movies
  end
end
