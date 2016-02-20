class User < ActiveRecord::Base
  has_many :movies
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
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end
end
