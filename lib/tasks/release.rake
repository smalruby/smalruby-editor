# -*- coding: utf-8 -*-

task :build do
  ENV['GEM_PLATFORM'] = 'linux'
  Rake::Task['gem:build'].invoke

  ENV['GEM_PLATFORM'] = 'x86-mingw32'
  Rake::Task['gem:build'].reenable
  Rake::Task['gem:build'].invoke
end

task :release do
  ENV['GEM_PLATFORM'] = 'linux'
  Rake::Task['gem:release'].invoke

  ENV['GEM_PLATFORM'] = 'x86-mingw32'
  Rake::Task['gem:release'].reenable
  Rake::Task['gem:build'].reenable
  Rake::Task['gem:release'].invoke

  sh 'git mirror'
  Bundler.with_clean_env do
    sh 'relish push smalruby/smalruby-editor'
  end

  require 'smalruby_editor/version'
  next_version = SmalrubyEditor::VERSION.split('.').tap { |versions|
    versions[-1] = (versions[-1].to_i + 1).to_s
  }.join('.')
  File.open('lib/smalruby_editor/version.rb', 'r+') do |f|
    lines = []
    while line = f.gets
      line = "#{$1}'#{next_version}'\n" if /(\s*VERSION =\s*)/.match(line)
      lines << line
    end
    f.rewind
    f.write(lines.join)
  end
  sh 'git add lib/smalruby_editor/version.rb'
  sh "git commit -m #{next_version}"
  sh 'git push'
end
