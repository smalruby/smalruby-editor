class AddIndexNameOnUsers < ActiveRecord::Migration
  def up
    add_index :users, :name, :unique
  end

  def down
    remove_index :users, :name
  end
end
