# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n_interpolation_spec/version'

Gem::Specification.new do |spec|
  spec.name          = 'i18n_interpolation_spec'
  spec.version       = I18nInterpolationSpec::VERSION
  spec.authors       = ['Yuki Iwanaga']
  spec.email         = ['yuki@creasty.com']
  spec.summary       = %q{RSpec matchers for testing the completeness of interpolation arguments in locale files}
  spec.description   = %q{RSpec matchers for testing the completeness of interpolation arguments in locale files}
  spec.homepage      = 'https://github.com/creasty/i18n_interpolation_spec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec', '>= 3.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
