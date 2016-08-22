task :rubocop do
  sh 'rubocop --rails app lib bin config spec'
end
