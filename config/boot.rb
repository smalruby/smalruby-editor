# Set up gems listed in the Gemfile.
if ENV['RAILS_ENV'] == 'standalone'
  require 'pathname'
  path = Pathname('../../smalruby-editor.gemspec').expand_path(__FILE__)
  spec = Dir.chdir(path.dirname.to_s) {
    # rubocop:disable Eval
    eval(path.read, TOPLEVEL_BINDING, path.to_s)
    # rubocop:enable Eval
  }
  exclude_gems = %w[
    therubyracer
    smalruby
    eco-source
  ]
  spec.runtime_dependencies.each do |s|
    require s.name unless exclude_gems.include?(s.name)
  end
else
  ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

  require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
end
