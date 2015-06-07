class InsertPresetCostumes < ActiveRecord::Migration
  def up
    Costume.create_presets
  end

  def down
    Costume.destroy_presets
  end
end
