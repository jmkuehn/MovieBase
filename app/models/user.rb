class User < ActiveRecord::Base
  has_many :statuses
  has_many :movies, through: :statuses

  has_many :services

  def watched_movies
    self.movies.where(watched: true)
  end

  def unwatched_movies
    self.movies.where(watched: false)
  end

  def friends_with_movielists
    # Do the facebook API stuff
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth['credentials']['token']
      if auth['info']
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
