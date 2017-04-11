class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    # :users is the table, :password_digest is the name of the column, :string is the type of input
    add_column :users, :password_digest, :string
  end
end
