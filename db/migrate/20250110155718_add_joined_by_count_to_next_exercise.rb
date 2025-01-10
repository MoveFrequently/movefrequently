class AddJoinedByCountToNextExercise < ActiveRecord::Migration[8.1]
  def change
    add_column :next_exercises, :joined_by_count, :integer, default: 0
  end
end
