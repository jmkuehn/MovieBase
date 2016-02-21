class MoviesController < ApplicationController
  def show
    @movie = Movie.get_by_id(params[:id])
  end

  def search
    @movies = Movie.search_by_string(params[:search][:search_string])
    render :search
  end

  def watched
    @movie = current_or_new_movie(params[:format])
    @status = current_or_new_status(@movie)

    @status.update_attribute(:watched, true)

    redirect_to root_path
  end

  def unwatched
    @movie = current_or_new_movie(params[:format])
    @status = current_or_new_status(@movie)

    @status.update_attribute(:watched, false)

    redirect_to root_path
  end

  private
  def current_or_new_movie(id)
    @movie = Movie.find_by_api_id(id)

    if @movie.nil?
      @api_movie = Movie.get_by_id(id)
      @movie = Movie.new
      @movie.api_id = params[:id]
      @movie.title = @api_movie["title"]
      @movie.thumbnail = @api_movie["thumbnail"]
      @movie.save!
    end

    @movie
  end

  def current_or_new_status(movie)
    @status = current_user.statuses.find_by_movie_id(movie)

    if @status.nil?
      @status = Status.new
      @status.user = current_user
      @status.movie = movie
      @status.save!
    end

    @status
  end
end
