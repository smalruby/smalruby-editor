require "smalruby_editor"

class Preference < Settingslogic
  BOOLEAN_FIELD_REGEXP = /(enabled|disabled)/

  def self.toolbox_names
    %w(
      default
      smalrubot_v3
      smalrubot_s1
    )
  end

  def self.toolbox_preference_names
    %w(
      toolbox__default__enabled_hardware_blocks
      toolbox__default__enabled_smalrubot_v3_blocks
      toolbox__default__enabled_smalrubot_s1_blocks
    )
  end

  def self.general_preference_names
    %w(
      disabled_add_character_from_beginning
      disabled_new_character
      enabled_readonly_ruby_mode
      hardware_port
    )
  end

  def self.admin_preference_names
    %w(
      enabled_must_signin
    )
  end

  def self.whole_preference_names
    ["toolbox_name"] + toolbox_preference_names +
      general_preference_names + admin_preference_names
  end

  def self.defaults
    (toolbox_preference_names +
     general_preference_names).map { |n|
      case n
      when BOOLEAN_FIELD_REGEXP
        [n, false]
      else
        [n, ""]
      end
    }.to_h.merge("toolbox_name" => "default")
  end

  def self.make_toolbox_name_to_preference_names_hash
    toolbox_preference_names.group_by { |n|
      n.slice(/^toolbox__(.+?)__/, 1)
    }
  end

  def initialize(hash_or_file = self.class.source, section = nil)
    super
  rescue NoMethodError
    replace({})
    @section = section || self.class.source
    create_accessors!
  end

  path = SmalrubyEditor.home_directory.join("config", "config.yml")
  if path.exist?
    source(path)
  else
    source({})
  end
  load!
  suppress_errors(true)
end
