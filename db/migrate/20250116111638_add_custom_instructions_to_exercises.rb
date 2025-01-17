class AddCustomInstructionsToExercises < ActiveRecord::Migration[8.1]
  def change
    add_column :exercises, :custom_instructions, :text
  end
end
