class MoviesController < ApplicationController
  def show
    @movie = Movie.get_by_id(params[:id])
  end

  def search
    @movies = Movie.search_by_string(params[:search][:search_string])
    render :search
  end
end
