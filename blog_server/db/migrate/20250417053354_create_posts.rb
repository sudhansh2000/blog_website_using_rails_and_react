class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :is_private, default: false
      t.json :tags, default: []

      t.timestamps
    end
  end
end
