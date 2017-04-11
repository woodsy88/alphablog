class AddUserIdToArticles < ActiveRecord::Migration
  def change
    # :table, :column.:type
    add_column :articles, :user_id, :integer
  end
end
