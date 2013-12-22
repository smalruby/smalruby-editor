# Set up gems listed in the Gemfile.
if ENV['RAILS_ENV'] == 'standalone'
  require 'pathname'
  path = Pathname('../../smalruby-editor.gemspec').expand_path(__FILE__)
  spec = Dir.chdir(path.dirname.to_s) {
    # rubocop:disable Eval
    eval(path.read, TOPLEVEL_BINDING, path.to_s)
    # rubocop:enable Eval
  }
  spec.runtime_dependencies.each do |spec_dep|
    require spec_dep.name
  end
else
  ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

  require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
end
