# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'uroman/version'

Gem::Specification.new do |s|
  s.name        = 'uroman'
  s.version     = Uroman::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Johnny Shields', 'Ulf Hermjakob']
  s.email       = 'johnny.shields@gmail.com'
  s.homepage    = 'https://github.com/tablecheck/uroman-ruby'
  s.summary     = 'uroman is a universal romanizer'
  s.description = 'Converts text in any script to the standard Latin alphabet.'
  s.license     = 'MIT'

  s.metadata = {
    'rubygems_mfa_required' => 'true',
    'bug_tracker_uri' => 'https://github.com/tablecheck/uroman-ruby/issues',
    'changelog_uri' => 'https://github.com/tablecheck/uroman-ruby/releases',
    'homepage_uri' => 'https://github.com/tablecheck/uroman-ruby',
    'source_code_uri' => 'https://github.com/tablecheck/uroman-ruby'
  }

  s.required_ruby_version = '>= 3.0'
  s.add_dependency('unicode-name')
  s.add_dependency('unicode-numeric_value')
  s.add_dependency('unicode-types')

  s.files = Dir.glob('lib/**/*') + %w[LICENSE.txt README.md]
  s.require_path = 'lib'
end
