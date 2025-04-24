class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :cat_name

      t.timestamps
    end
  end
end
