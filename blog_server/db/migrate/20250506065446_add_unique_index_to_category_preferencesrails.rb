class AddUniqueIndexToCategoryPreferencesrails < ActiveRecord::Migration[8.0]
  def change
    add_index :category_preferences, [ :user_id, :category_id ], unique: true
    add_index :bookmarks, [ :user_id, :post_id ], unique: true
    add_index :share_posts, [ :sender_id, :receiver_id, :post_id ], unique: true
  end
end
