class UsersController < ApplicationController
  before_action :require_authentication

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    @friends = @user.friends
  end
end
