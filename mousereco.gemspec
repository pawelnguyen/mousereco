$:.push File.expand_path("../lib", __FILE__)

require "mousereco/version"

Gem::Specification.new do |s|
  s.name = "mousereco"
  s.version = Mousereco::VERSION
  s.authors = ["Paweł Nguyen", "Krzysztof Krztoń"]
  s.email = ["pawel.nguyen@gmail.com", "krzysztof@krzton.com"]
  s.homepage = "https://github.com/pawelnguyen/mousereco"
  s.summary = "Mouse recording for Rails"
  s.description = "Mousereco is a mouse recording Gem with a web interface used to replay user visits"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "inherited_resources"

  s.add_development_dependency "sqlite3"
end
