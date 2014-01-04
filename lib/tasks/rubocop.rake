task :rubocop do
  sh 'bundle exec rubocop --rails app lib bin config spec'
end
