class InsertPresetCostumes < ActiveRecord::Migration
  def up
    Costume::PRESET_COSTUME_NAMES.each.with_index do |name, index|
      Costume.find_or_create_by(name: name, position: index, preset: true)
    end
  end

  def down
    Costume.where(name: Costume::PRESET_COSTUME_NAMES, preset: true)
      .destroy_all
  end
end
