class AddCounterCacheToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :likes_count, :integer
    add_column :articles, :comments_count, :integer
  end
end
