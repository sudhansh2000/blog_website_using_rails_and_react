class CreateSharePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :share_posts do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
