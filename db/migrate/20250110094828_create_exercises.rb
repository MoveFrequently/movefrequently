class CreateExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :description
      t.json :steps, default: [], null: false

      t.timestamps
    end

    add_index :exercises, :created_at, order: :desc
  end
end
