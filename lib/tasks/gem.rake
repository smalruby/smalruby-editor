require 'bundler/gem_tasks'

task 'assets:precompile:standalone' do
  Rails.env = ENV['RAILS_ENV'] = 'standalone'
  Rake::Task['assets:precompile'].invoke
end

task 'build' => ['assets:clobber', 'assets:precompile:standalone']


