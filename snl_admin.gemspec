lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require 'snl_admin/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'snl_admin'
  spec.version     = SnlAdmin::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Peter Kordel']
  spec.email       = ['pkordel@gmail.com']
  spec.homepage    = 'http://pkordel.github.com'
  spec.description   = %(This gem provides a simple admin interface.)
  spec.summary       = %(This gem provides a simple admin interface.)
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 5.0.0.1'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'chartkick'
  spec.add_dependency 'kaminari'
  spec.add_dependency 'bootstrap-kaminari-views'

  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
