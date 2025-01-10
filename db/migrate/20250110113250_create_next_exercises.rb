class CreateNextExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :next_exercises do |t|
      t.belongs_to :exercise, null: false, foreign_key: true
      t.datetime :next_at, null: false
    end

    add_index :next_exercises, :next_at, order: :desc
  end
end
