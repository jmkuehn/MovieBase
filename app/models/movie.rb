class Movie < ActiveRecord::Base
  belongs_to :user
  has_many :services

  validates :watched, presence: true

  def self.get_by_id(movie_id)
    response = HTTParty.get("http://metadata.sls1.cdops.net/Product/SystemId/e5ce3167-4e0b-4867-a8c3-c8f23aec5e71/DistributionChannel/20389393-b2e4-4f65-968e-75a5227e544c/Id/#{movie_id}")
    @movie = {
      "id": movie_id,
      "title": response["Product"]["Name"],
      "thumbnail": response["Product"]["ThumbnailUrl"],
      "short_description": response["Product"]["ShortDescription"],
      "rating": response["Product"]["GuidanceRatings"]["Name"],

    }
  end

  def self.search_by_string(search_string)
  end
end
