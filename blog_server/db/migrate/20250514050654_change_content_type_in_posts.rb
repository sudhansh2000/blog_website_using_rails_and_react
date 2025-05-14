class ChangeContentTypeInPosts < ActiveRecord::Migration[8.0]
  def change
    change_column :posts, :content, :text, null: false, default: ""
  end
end
