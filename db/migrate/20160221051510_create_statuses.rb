class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :movie, index: true
      t.boolean :watched, default: false, null: false
      t.integer :rating

      t.timestamps null: false
    end
  end
end
