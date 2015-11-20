# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generic_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'generic_gem'
  spec.version       = GenericGem::VERSION
  spec.authors       = ['Jason Hsu']
  spec.email         = ['rubyist@jasonhsu.com']

  spec.summary       = 'GenericGem streamlines the process of starting a new Ruby gem.'
  spec.description   = 'GenericGem executes the bundle command but fills in important but easily forgotten details.'
  spec.homepage      = 'https://github.com/jhsu802701/generic_gem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = 'generic_gem'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.8'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sandi_meter'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'gemsurance'

  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_runtime_dependency 'string_in_file'
  spec.add_runtime_dependency 'replace_quotes'
end
