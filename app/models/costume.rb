class Costume < ActiveRecord::Base
  acts_as_taggable

  PRESET_COSTUME_SETTINGS = [
    { name: "car1", tag_list: %w(Preset Car) },
    { name: "car2", tag_list: %w(Preset Car) },
    { name: "car3", tag_list: %w(Preset Car) },
    { name: "car4", tag_list: %w(Preset Car) },
    { name: "cat1", tag_list: %w(Preset Animal Cat) },
    { name: "cat2", tag_list: %w(Preset Animal Cat) },
    { name: "cat3", tag_list: %w(Preset Animal Cat) },
    { name: "frog1", tag_list: %w(Preset Aminal Frog) },
    { name: "ball1", tag_list: %w(Preset Ball) },
    { name: "ball2", tag_list: %w(Preset Ball) },
    { name: "ball3", tag_list: %w(Preset Ball) },
    { name: "ball4", tag_list: %w(Preset Ball) },
    { name: "ball5", tag_list: %w(Preset Ball) },
    { name: "ball6", tag_list: %w(Preset Ball) },
    { name: "ryu1", tag_list: %w(Preset Human Ninja) },
    { name: "ryu2", tag_list: %w(Preset Human Ninja) },
    { name: "taichi1", tag_list: %w(Preset Animal Ninja) },
    { name: "taichi2", tag_list: %w(Preset Animal Ninja) },
  ]

  belongs_to :user

  scope :presets, -> { where(preset: true) }
  scope :default_order, -> { order(preset: :asc, position: :asc) }

  class << self
    def create_presets
      PRESET_COSTUME_SETTINGS.each.with_index do |setting, index|
        costume = Costume.find_or_create_by(name: setting[:name],
                                            position: index,
                                            preset: true)
        costume.tag_list = setting[:tag_list]
        costume.save!
      end
    end

    def destroy_presets
      names = PRESET_COSTUME_SETTINGS.map { |s| s[:name] }
      where(name: names, preset: true).destroy_all
    end
  end

  def url
    "/smalruby/assets/#{basename}"
  end

  def path
    if preset?
      Rails.root.join("public/smalruby/assets/#{basename}")
    else
      s = "~/#{user.name}/__assets__/#{basename}"
      Pathname(s).expand_path
    end
  end

  def basename=(val)
    self.name = val.sub(/\.png$/, "")
  end

  def basename
    "#{name}.png"
  end
end
