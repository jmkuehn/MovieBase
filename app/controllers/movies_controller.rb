class MoviesController < ApplicationController
  before_action :require_authentication

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

    flash[:success] = "You have successfully watched a movie!"
    redirect_to movie_path(@movie.api_id)
  end

  def unwatched
    @movie = current_or_new_movie(params[:format])
    @status = current_or_new_status(@movie)

    @status.update_attribute(:watched, false)

    flash[:success] = "You want to watch a movie!"
    redirect_to movie_path(@movie.api_id)
  end

  private
  def current_or_new_movie(id)
    @movie = Movie.find_by_api_id(id)

    if @movie.nil?
      @api_movie = Movie.get_by_id(id)
      @movie = Movie.new
      @movie.api_id = id
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
