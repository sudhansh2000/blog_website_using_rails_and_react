class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      # t.integer :parent_id, foreign_key: { to_table: :comments }
      t.references :parent, null: true, foreign_key: { to_table: :comments }
      # t.references :comment, null: true, foreign_key: true
      # t.integer :parent_id
      t.string :content

      t.timestamps
    end
  end
end
