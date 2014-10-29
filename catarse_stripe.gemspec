#encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "catarse_stripe/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "catarse_stripe"
  s.version     = CatarseStripe::VERSION
  s.authors     = ["Matt Hall", "Antônio Roberto Silva", "Diogo Biazus", "Josemar Davi Luedke"]
  s.email       = ["matt@codebeef.com", "forevertonny@gmail.com", "diogob@gmail.com", "josemarluedke@gmail.com"]
  s.homepage    = "http://github.com/Codebeef/catarse_stripe"
  s.summary     = "Stripe integration with Catarse"
  s.description = "Stripe integration with Catarse crowdfunding platform"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "slim-rails"
  s.add_dependency "stripe"

  s.add_development_dependency "pg"
  s.add_development_dependency "catarse"
  s.add_development_dependency "spree_core", '~> 2.3'
  s.add_development_dependency "rspec-rails", '~> 2.14.0'
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
