require 'bundler/gem_helper'

namespace :gem do
  Bundler::GemHelper.install_tasks
end

task 'assets:precompile:standalone' do
  Rails.env = ENV['RAILS_ENV'] = 'standalone'
  Rake::Task['assets:precompile'].reenable
  Rake::Task['assets:precompile'].invoke
end

task 'gem:build' => ['assets:clobber', 'assets:precompile:standalone']
