class User < ActiveRecord::Base
  has_many :movies
  has_manu :services

  def watched_movies
    self.movies.where(watched: true)
  end

  def unwatched_movies
    self.movies.where(watched: false)
  end

  def friends_with_movielists
    # Do the facebook API stuff
  end
end
