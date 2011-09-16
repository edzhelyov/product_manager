require File.expand_path('../lib/product_manager/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "product_manager"
  s.version       = ProductManager::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Evgeni Dzhelyov"]
  s.homepage      = "http://github.com/edzhelyov/product_manager"
  s.summary       = "Simple EAV model implementation for managing products"
  s.description   = "Product Manager allow you to create new products and define dynamic attributes on them. Abstracting all interaction with the product throught a Product class, this way hiding the actual EAV model details."

  s.files         = Dir["{app,lib,config}/**/*"] + ["Rakefile", "Gemfile", "README.md"]

  s.add_dependency "rails", "~>3.0.10"
  s.add_dependency "sqlite3"
  s.add_dependency "rspec-rails", "~>2.6"
end
