# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_save/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_save"
  spec.version       = EasySave::VERSION
  spec.authors       = ["Akshith Yellapragada"]
  spec.email         = ["ayellapragada@gmail.com"]

  spec.summary       = "Easy to use lightweight ORM that abstracts away complex database queries."
  spec.homepage      = "https://github.com/ayellapragada/EasySave"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "activesupport"
end
