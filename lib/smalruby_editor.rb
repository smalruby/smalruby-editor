require 'smalruby_editor/version'

module SmalrubyEditor
  def create_home_directory(home_dir = nil)
    if home_dir.blank?
      path = ENV['SMALRUBY_EDITOR_HOME'] || '~/.smalruby-editor'
      home_dir = Pathname(path).expand_path
    end
    create_under_home_directories(home_dir)
    create_database_yml(home_dir)
    home_dir
  end
  module_function :create_home_directory

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
      unless File.exist?(database_yml_path)
        File.open(database_yml_path, 'w') do |f|
          f.write(DATABASE_YML_TEMPLATE.gsub(/%db_path%/, db_path.to_s))
        end
      end
    end
  end
end
