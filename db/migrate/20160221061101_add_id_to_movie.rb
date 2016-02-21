class AddIdToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :api_id, :integer, unique: true, null: false
  end
end
