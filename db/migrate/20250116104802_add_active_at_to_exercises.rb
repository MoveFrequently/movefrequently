class AddActiveAtToExercises < ActiveRecord::Migration[8.1]
  def change
    add_column :exercises, :active_at, :datetime
    add_index :exercises, :active_at
  end
end
