# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Baidupush/version'

Gem::Specification.new do |spec|
  spec.name          = "Baidupush"
  spec.version       = Baidupush::VERSION
  spec.authors       = ["zql"]
  spec.email         = ["hahazhouqunli@gmail.com"]
  spec.description   = %q{百度云推送的SDK}
  spec.summary       = %q{百度云推送}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
