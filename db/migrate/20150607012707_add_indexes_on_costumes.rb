class AddIndexesOnCostumes < ActiveRecord::Migration
  def up
    add_index :costumes, :name
    add_index :costumes, :position
    add_index :costumes, :user_id
  end

  def down
    remove_index :costumes, :name
    remove_index :costumes, :position
    remove_index :costumes, :user_id
  end
end
