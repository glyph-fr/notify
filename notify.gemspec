$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "notify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "notify"
  s.version     = Notify::VERSION
  s.authors     = ["Valentin Ballestrino"]
  s.email       = ["vala@glyph.fr"]
  s.homepage    = "http://www.glyph.fr"
  s.summary     = "Flexible notification system for your Rails app"
  s.description = "Flexible notification system for your Rails app"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "sucker_punch", "~> 1.0"
  s.add_dependency "kaminari"

  s.add_development_dependency "sqlite3"
end
