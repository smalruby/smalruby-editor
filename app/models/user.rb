class User < ActiveRecord::Base
  serialize :preferences

  before_save do
    preferences.each do |key, value|
      case key
      when Preference::BOOLEAN_FIELD_REGEXP
        if !value.is_a?(TrueClass) && !value.is_a?(FalseClass)
          if %w(true 1).include?(value)
            preferences[key] = true
          else
            preferences[key] = false
          end
        end
      end
    end
  end

  # set default preferences from SMALRUBY_HOME/config/config.yml
  def set_default_preferences
    self.preferences = Preference.user_defaults
    h = Preference.to_h
    (Preference.whole_preference_names -
     Preference.admin_preference_names).each do |name|
      preferences[name] = h[name]
    end
  end
end
