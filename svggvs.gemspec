# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'svggvs/version'

Gem::Specification.new do |gem|
  gem.name          = "svggvs"
  gem.version       = Svggvs::VERSION
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Generate sets of card game cards using Inkscape templates and Ruby}
  gem.summary       = %q{Generate sets of card game cards using Inkscape templates and Ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'thor'
end
