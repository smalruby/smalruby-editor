require 'bundler/gem_helper'

namespace :gem do
  Bundler::GemHelper.install_tasks
end

task 'gem:build' => ['assets:clobber', 'assets:precompile']
