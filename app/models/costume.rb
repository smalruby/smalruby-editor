class Costume < ActiveRecord::Base
  PRESET_COSTUME_NAMES = %w(
    car1
    car2
    car3
    car4
    cat1
    cat2
    cat3
    frog1
    ball1
    ball2
    ball3
    ball4
    ball5
    ball6
    ryu1
    ryu2
    taichi1
    taichi2
  )

  has_one :user

  scope :presets, -> { where(preset: true) }
  scope :default_order, -> { order(preset: :asc, position: :asc) }

  def path
    "/smalruby/assets/#{basename}"
  end

  def basename
    "#{name}.png"
  end
end
