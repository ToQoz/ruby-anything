# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-anything/version'

Gem::Specification.new do |gem|
  gem.name          = "pry-anything"
  gem.version       = PryAnything::VERSION
  gem.authors       = ["Takatoshi Matsumoto"]
  gem.email         = ["toqoz403@gmail.com"]
  gem.description   = %q{Anything interface for pry}
  gem.summary       = %q{Provide anything interface for pry. Adds 'anything' command to pry}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
