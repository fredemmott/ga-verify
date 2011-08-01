# -*- encoding: utf-8 -*-
require 'rake'

Gem::Specification.new do |s|
  s.name        = "ga_verify"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fred Emmott"]
  s.email       = ["mail@fredemmott.co.uk"]
  s.homepage    = "https://github.com/fredemmott/ga-verify"
  s.summary     = "Thrift client and server for validating google authenticator tokens"
  s.description = "Provides a unix socket for validating tokens"

  s.add_dependency 'rotp',   '~> 1.3.0'
  s.add_dependency 'thrift', '~> 0.6.0'

  s.files       = FileList[
    'bin/*',
    'lib/**/*.rb',
    'gen-rb/*.rb',
    'if/*.thrift',
  ].to_a
  s.executables = ['ga-verify', 'ga-verifyd']
end
