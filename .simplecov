if ENV['COVERALLS']
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end

SimpleCov.start('rails')
