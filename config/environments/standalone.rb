require_relative 'production'

SmalrubyEditor::Application.configure do
  if ENV['SMALRUBY_EDITOR_HOME'].present?
    home_dir = SmalrubyEditor.create_home_directory

    config.paths.add('config/database',
                     with: home_dir.join('config/database.yml'))
    config.paths.add('log', with: home_dir.join("log/#{Rails.env}.log"))
    config.paths.add('tmp', with: home_dir.join('tmp'))
    config.paths.add('tmp/cache', with: home_dir.join('tmp/cache'))
  end

  config.serve_static_assets = true
  config.log_level = :warn
end
