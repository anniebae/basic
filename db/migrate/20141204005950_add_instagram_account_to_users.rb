class AddInstagramAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instagram_account, :string
  end
end
