class Movie < ActiveRecord::Base
  has_many :statuses, dependent: :destroy
  has_many :users, through: :statuses

  has_many :services

  def self.get_by_id(movie_id)
    response = HTTParty.get("http://metadata.sls1.cdops.net/Product/SystemId/e5ce3167-4e0b-4867-a8c3-c8f23aec5e71/DistributionChannel/20389393-b2e4-4f65-968e-75a5227e544c/Id/#{movie_id}")

    if response["Product"]["GuidanceRatings"]
      @ratings = []
      response["Product"]["GuidanceRatings"].each do |rating|
        @ratings << rating["Name"]
      end
      @ratings = @ratings.join(", ")
    else
      @ratings = "N/A"
    end

    if response["Product"]["People"]
      @cast = []
      response["Product"]["People"].each do |person|
        @cast << person["DisplayName"]
      end
      @cast = @cast.join(", ")
    else
      @cast = "N/A"
    end

    if response["Product"]["Runtime"]
      @runtime = Integer(response["Product"]["Runtime"])
      @runtime = "#{(@runtime - (@runtime % 60)) / 60}h #{@runtime % 60}m"
    else
      @runtime = "N/A"
    end

    if response["Product"]["ReleaseDate"]
      @releasedate = response["Product"]["ReleaseDate"].split("T")[0]
    else
      @releasedate = "N/A"
    end

    if response["Product"]["ReferencedProducts"]
      @related = []
      response["Product"]["ReferencedProducts"].each do |product|
        unless product["Value"]["Id"] == movie_id
          @related_movie = {
            "id" => product["Value"]["Id"],
            "thumbnail" => product["Value"]["ThumbnailUrl"]
          }
          @related << @related_movie
        end
      end
    else
      @related = nil
    end

    @title = response["Product"]["Name"] || "N/A"
    @thumbnail = response["Product"]["ThumbnailUrl"] || "N/A"
    @short_description = response["Product"]["ShortDescription"] || "N/A"
    @genre = response["Product"]["Genre"] || "N/A"

    @movie = {
      "id" => movie_id,
      "title" => @title,
      "thumbnail" => @thumbnail,
      "short_description" => @short_description,
      "rating" => @ratings,
      "genre" => @genre,
      "cast" => @cast,
      "release_date" => @releasedate,
      "runtime" => @runtime,
      "related" => @related
    }
  end

  def self.search_by_string(search_string)
    response = HTTParty.get("http://metadata.sls1.cdops.net/SearchSuggestions/SystemId/e5ce3167-4e0b-4867-a8c3-c8f23aec5e71/DistributionChannel/20389393-b2e4-4f65-968e-75a5227e544c/SearchString/#{search_string.gsub(' ', '%20').html_safe}/IncludeProducts/True")

    if response["Products"]
      @movies = []
      response["Products"].each do |product|
        if product["GuidanceRatings"]
          @ratings = []
          product["GuidanceRatings"].each do |rating|
            @ratings << rating["Name"]
          end
          @ratings = @ratings.join(", ")
        else
          @ratings = "N/A"
        end

        @title = product["Name"] || "N/A"
        @thumbnail = product["ThumbnailUrl"] || "N/A"
        @short_description = product["ShortDescription"] || "N/A"

        @movie = {
          "id" => product["Id"],
          "title" => @title,
          "thumbnail" => @thumbnail,
          "short_description" => @short_description,
          "rating" => @ratings
        }
        @movies << @movie
      end
    else
      @movies = nil
    end

    @movies
  end
end
