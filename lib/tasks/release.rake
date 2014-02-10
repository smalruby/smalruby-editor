# -*- coding: utf-8 -*-

task :build do
  ENV['GEM_PLATFORM'] = 'linux'
  Rake::Task['gem:build'].invoke

  ENV['GEM_PLATFORM'] = 'mingw32'
  Rake::Task['gem:build'].reenable
  Rake::Task['assets:clobber'].reenable
  Rake::Task['assets:precompile'].reenable
  Rake::Task['gem:build'].invoke
end

task :release do
  ENV['GEM_PLATFORM'] = 'linux'
  Rake::Task['gem:release'].invoke

  ENV['GEM_PLATFORM'] = 'mingw32'
  Rake::Task['gem:release'].reenable
  Rake::Task['gem:build'].reenable
  Rake::Task['assets:clobber'].reenable
  Rake::Task['assets:precompile'].reenable
  Rake::Task['gem:release'].invoke

  sh 'git mirror'
  sh 'relish push smalruby/smalruby-editor'

  require 'lib/smalruby_editor/version'
  next_version = SmalrubyEditor::VERSION.split('.').tap { |versions|
    versions[-1] = (versions[-1].to_i + 1).to_s
  }.join('.')
  File.open('lib/smalruby_editor/version.rb', 'w+') do |f|
    lines = []
    while line = f.gets
      line = "#{$1} '#{next_version}'\n" if /(\s*VERSION = )/.match(line)
      lines << line
    end
    f.rewind
    f.write(lines.join("\n"))
  end
  sh "git commit -m 'バージョンを#{next_version}に更新'"
  sh 'git push'
end
