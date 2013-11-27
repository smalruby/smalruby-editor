require 'bundler/gem_tasks'

task 'build' => ['assets:clobber', 'assets:precompile']


