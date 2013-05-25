$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "snl_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "snl_admin"
  s.version     = SnlAdmin::VERSION
  s.authors     = ["Peter Kordel"]
  s.email       = ["pkordel@gmail.com"]
  s.homepage    = "http://pkordel.github.com"
  s.summary     = "Summary of SnlAdmin."
  s.description = "Description of SnlAdmin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "pg"
  s.add_development_dependency "activerecord-postgres-hstore"

end
