class MoviesController < ApplicationController
  def show
    @movie = Movie.get_by_id(params[:id])
  end
end
