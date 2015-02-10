# -*- coding: utf-8 -*-
require 'smalruby_editor/version'

module SmalrubyEditor
  # ジャンルのカラー
  COLORS = {
    character: 198,
    control: 43,
    data: 330,
    etc: 340,
    events: 33,
    looks: 270,
    motion: 208,
    operators: 100,
    pen: 160,
    ruby: 340,
    sensing: 190,
    sound: 300,
  }

  # http://c4se.hatenablog.com/entry/2013/08/04/190937 をほぼコピーした
  def hsv_to_rgb(h, s, v)
    s /= 100.0
    v /= 100.0
    c = v * s
    x = c * (1 - ((h / 60.0) % 2 - 1).abs)
    m = v - c
    r, g, b = *(
      case
      when h < 60  then [c, x, 0]
      when h < 120 then [x, c, 0]
      when h < 180 then [0, c, x]
      when h < 240 then [0, x, c]
      when h < 300 then [x, 0, c]
      else              [c, 0, x]
      end
    )
    [r, g, b].map { |channel|
      sprintf('%02x', ((channel + m) * 255).ceil)
    }.join
  end
  module_function :hsv_to_rgb

  # return smalruby's home directory
  # (default is '~/.smalruby-editor').
  def home_directory
    path = ENV['SMALRUBY_EDITOR_HOME'] || '~/.smalruby-editor'
    Pathname(path).expand_path
  end
  module_function :home_directory

  def create_home_directory(home_dir = nil)
    if home_dir.blank?
      path = ENV['SMALRUBY_EDITOR_HOME'] || '~/.smalruby-editor'
      home_dir = Pathname(path).expand_path
    end
    create_under_home_directories(home_dir)
    create_database_yml(home_dir)
    create_config_yml(home_dir)
    home_dir
  end
  module_function :create_home_directory

  # Raspberry Piかどうかを返す
  def raspberrypi?
    if Rails.env != 'test' &&
        (ENV['SMALRUBY_EDITOR_RASPBERRYPI_MODE'] ||
         File.exist?(Rails.root.join('tmp', 'raspberrypi')))
      true
    else
      RbConfig::CONFIG['arch'] == 'armv6l-linux-eabihf'
    end
  end
  module_function :raspberrypi?

  # Mac OS Xかどうかを返す
  def osx?
    if Rails.env != 'test' &&
        (ENV['SMALRUBY_EDITOR_OSX_MODE'] ||
         File.exist?(Rails.root.join('tmp', 'osx')))
      true
    else
      /darwin/ =~ RbConfig::CONFIG['arch']
    end
  end
  module_function :osx?

  # Windowsかどうかを返す
  def windows?
    if Rails.env != 'test' &&
        (ENV['SMALRUBY_EDITOR_WINDOWS_MODE'] ||
         File.exist?(Rails.root.join('tmp', 'windows')))
      true
    else
      /windows|mingw|cygwin/i.match(RbConfig::CONFIG['arch'])
    end
  end
  module_function :windows?

  class << self
    private

    def create_under_home_directories(home_dir)
      dirs = %w(log db config
                tmp/cache tmp/pids tmp/sessions tmp/sockets).map { |s|
        home_dir.join(s)
      }
      dirs.each do |dir|
        FileUtils.mkdir_p(dir)
      end
    end

    DATABASE_YML_TEMPLATE = <<-EOS
standalone:
  adapter: sqlite3
  database: %db_path%
  pool: 5
  timeout: 5000
    EOS

    def create_database_yml(home_dir)
      database_yml_path = home_dir.join('config', 'database.yml')
      db_path = home_dir.join('db', 'standalone.sqlite3')
      File.open(database_yml_path, 'w') do |f|
        f.write(DATABASE_YML_TEMPLATE.gsub(/%db_path%/, db_path.to_s))
      end
    end

    CONFIG_YML_TEMPLATE = <<-EOS
#toolbox_name: default
#toolbox_name: raspberrypi
#toolbox_name: smalrubot_v3
#toolbox_name: smalrubot_s1
#toolbox_name: default
#toolbox_css_name: default
features:
  #- disabled_add_character_from_beginning
  #- disabled_new_character
  #- auto_init_hardware
  #- readonly_ruby_mode
  #- must_signin
  #- enabled_hardware_blocks_on_default
  #- enabled_2wd_car_blocks_on_default
  #- enabled_smalrubot_v3_blocks_on_default
  #- enabled_smalrubot_s1_blocks_on_default
    EOS

    def create_config_yml(home_dir)
      config_yml_path = home_dir.join('config', 'config.yml')
      unless config_yml_path.exist?
        File.open(config_yml_path, 'w') do |f|
          f.write(CONFIG_YML_TEMPLATE)
        end
      end
    end
  end
end

require 'smalruby_editor/config'
