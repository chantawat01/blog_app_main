class RemoveTitleAndContentFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :title
    remove_column :posts, :content
  end
end
