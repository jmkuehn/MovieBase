class User < ActiveRecord::Base
  has_many :statuses
  has_many :movies, through: :statuses

  has_many :services

  def shared_unwatched_movies
    @movies_and_friends = []
    @friends = self.friends

    if !@friends.empty?
      @s_movies = self.unwatched_movies

      @friends.each do |friend|
        @f_movies = friend.unwatched_movies

        @s_movies.each do |movie1|
          @f_movies.each do |movie2|
            if movie1 == movie2
              @movies_and_friends << { "movie" => movie1, "friend" => friend.name }
            end
          end
        end
      end
    end

    @movies_and_friends
  end

  def watched_movies
    @movies = []
    self.statuses.where(watched: true).each do |status|
      @movies << status.movie
    end
    @movies
  end

  def unwatched_movies
    @movies = []
    self.statuses.where(watched: false).each do |status|
      @movies << status.movie
    end
    @movies
  end

  def friends
    @facebook = User.koala(self.id)
    @friends = []

    if @facebook["friends"]
      @facebook["friends"]["data"].each do |friend|
        @user = User.find_by_facebook_id(friend["id"])
        @friends << @user unless @user.nil?
      end

      @friends
    else
      nil
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth['credentials']['token']
      facebook = Koala::Facebook::API.new(user.token)
      if auth['info']
        user.facebook_id = facebook.get_object("me?fields=friends")['id'] || ""
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end

  def self.koala(id)
    facebook = Koala::Facebook::API.new(User.find(id).token)
    facebook.get_object("me?fields=friends")
  end

  def watched?(movie_api_id)
    @status = self.statuses.where(movie: Movie.find_by_api_id(movie_api_id))
    if @status.exists?
      @status.first.watched
    else
      false
    end
  end

  def unwatched?(movie_api_id)
    @status = self.statuses.where(movie: Movie.find_by_api_id(movie_api_id))
    if @status.exists?
      !@status.first.watched
    else
      false
    end
  end
end
