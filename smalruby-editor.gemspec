# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smalruby_editor/version'

Gem::Specification.new do |spec|
  spec.name          = 'smalruby-editor'
  spec.version       = SmalrubyEditor::VERSION

  spec.authors       = ['Kouji Takao']
  spec.email         = ['kouji.takao@gmail.com']
  spec.description   = %q{The smalruby-editor is a visual programming editor that can create a Ruby script by combining individual blocks similar to Scratch. It can also enter the program as better than Scratch.}
  spec.summary       = %q{A visual programming editor.}
  spec.homepage      = 'https://github.com/smalruby/smalruby-editor'
  spec.license       = 'MIT'

  spec.files         = []
  if File.exist?(File.expand_path('../.git', __FILE__))
    spec.files       += `git ls-files`.split($/)
    spec.files       -= ['Gemfile', 'Gemfile.lock']
  end
  spec.files         += Dir.glob('public/assets/**/*')
  spec.default_executable = 'smalruby-editor'
  spec.executables   = ['smalruby-editor']
  spec.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.rdoc_options  = ["--title", "Smalruby Editor -- A visual programming editor", "--line-numbers", "--main", "README", "--exclude", "app", "--exclude", "bin", "--exclude", "config", "--exclude", "db", "--exclude", "features", "--exclude", "lib", "--exclude", "log", "--exclude", "pkg", "--exclude", "public", "--exclude", "script", "--exclude", "spec", "--exclude", "test", "--exclude", "tmp", "--exclude", "vendor"]

  runtime_dependencies =
    [
     ['rails', '4.0.2'],
     ['sqlite3'],
     ['sass-rails', '~> 4.0.0'],
     ['uglifier', '>= 1.3.0'],
     ['coffee-rails', '~> 4.0.0'],
     ['jquery-rails'],
     ['turbolinks'],
     ['jbuilder', '~> 2.0'],
     ['ace-rails-ap'],
     ['flatstrap-sass'],
     ['jquery-fileupload-rails'],
     ['shared-mime-info'],
     ['launchy'],
    ]
  runtime_dependencies.each do |args|
    spec.add_runtime_dependency *args
  end

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
