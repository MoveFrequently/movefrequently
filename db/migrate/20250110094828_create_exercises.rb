class CreateExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :exercises do |t|
      t.string :description
      t.string :see_also

      t.timestamps
    end
  end
end
