class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, null: true, foreign_key: true
      t.integer :liked_on_id
      t.string :liked_on_type

      t.timestamps
    end
  end
end
