class CreateCostumes < ActiveRecord::Migration
  def change
    create_table :costumes do |t|
      t.string :name, null: false, unique: true
      t.boolean :preset, null: false, default: false
      t.integer :position, null: false
      t.references :user

      t.timestamps
    end
  end
end
