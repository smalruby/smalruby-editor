# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Costume::PRESET_COSTUME_NAMES.each.with_index do |name, index|
  Costume.find_or_create_by(name: name, position: index, preset: true)
end
