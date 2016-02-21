class UsersController < ApplicationController
  def index
  end

  def friends
  	@user = current_user

  	User.koala[:friends][:data].each do |friend|)

	@friend << User.find(friend.id)
  end
end
