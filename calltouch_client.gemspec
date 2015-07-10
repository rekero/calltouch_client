require File.join(File.dirname(__FILE__), 'lib', 'calltouch_client')

Gem::Specification.new do |s|
  s.name = 'calltouch_client'
  s.version = CalltouchClient::VERSION
  s.date = '2015-02-17'
  s.summary = 'Calltouch API client'
  s.description = 'Calltouch API client'
  s.authors = ['Tatiana Podimova']
  s.homepage = 'http://rubygems.org/gems/calltouch_client'
  s.license = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rest-client"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
