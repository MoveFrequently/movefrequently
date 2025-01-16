class AddActiveAtToExercises < ActiveRecord::Migration[8.1]
  def up
    add_column :exercises, :active_at, :datetime
    add_index :exercises, :active_at
    Exercise.unscoped.limit(10).each do |exercise|
      exercise.update(active_at: Time.now.utc)
    end
  end

  def down
    remove_index :exercises, :active_at
    remove_column :exercises, :active_at
  end
end
