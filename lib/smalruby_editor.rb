require 'smalruby_editor/version'

module SmalrubyEditor
  def create_home_directory(home_dir = nil)
    if home_dir.blank?
      home_dir = Pathname(ENV['SMALRUBY_EDITOR_HOME'] || '~/.smalruby-editor').expand_path
    end

    %w(log db config tmp/cache tmp/pids tmp/sessions tmp/sockets).map { |s|
      home_dir.join(s)
    }.each do |dir|
      FileUtils.mkdir_p(dir)
    end

    database_yml_path = home_dir.join('config', 'database.yml')
    db_path = home_dir.join('db', 'standalone.sqlite3')
    if !File.exist?(database_yml_path)
      File.open(database_yml_path, 'w') do |f|
        f.write(<<-EOS.strip_heredoc)
          standalone:
            adapter: sqlite3
            database: #{db_path}
            pool: 5
            timeout: 5000
        EOS
      end
    end

    home_dir
  end
  module_function :create_home_directory
end
