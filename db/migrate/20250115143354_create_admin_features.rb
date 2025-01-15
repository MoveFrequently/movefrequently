class CreateAdminFeatures < ActiveRecord::Migration[8.1]
  def change
    create_table :admin_features do |t|
      t.string :title
      t.text :feature

      t.timestamps
    end
  end
end
