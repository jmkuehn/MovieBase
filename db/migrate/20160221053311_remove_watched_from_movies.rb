class RemoveWatchedFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :watched
  end
end
