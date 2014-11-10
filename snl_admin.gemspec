# coding: utf-8
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
  spec.description   = %q{This gem provides a simple admin interface.}
  spec.summary       = %q{This gem provides a simple admin interface.}
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 3.2.20'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'sass-rails'
  spec.add_dependency 'strong_parameters'
  spec.add_dependency 'chartkick'
  spec.add_dependency 'kaminari'
  spec.add_dependency 'bootstrap-kaminari-views'
  spec.add_dependency 'pg'
  spec.add_dependency 'activerecord-postgres-hstore'

  spec.add_development_dependency 'bundler',  '~> 1.3'
  spec.add_development_dependency 'rake'

end
