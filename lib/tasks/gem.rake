require 'bundler/gem_helper'

namespace :gem do
  Bundler::GemHelper.install_tasks
end

task 'assets:precompile:standalone' do
  system('rake assets:precompile RAILS_ENV=production')
end

task 'gem:build' => ['assets:clobber', 'assets:precompile:standalone']
