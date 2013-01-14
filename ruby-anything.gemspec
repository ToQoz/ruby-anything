# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-anything/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby-anything"
  gem.version       = RubyAnything::VERSION
  gem.authors       = ["Takatoshi Matsumoto"]
  gem.email         = ["toqoz403@gmail.com"]
  gem.description   = %q{Anything interface for ruby}
  gem.summary       = %q{Provide anything interface for ruby. Adds method 'anything' to Kernel.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
