# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octokit_issue_export/version'

Gem::Specification.new do |spec|
  spec.name          = 'octokit_issue_export'
  spec.version       = OctokitIssueExport::VERSION
  spec.authors       = ['linyows']
  spec.email         = ['linyows@gmail.com']
  spec.description   = %q{Octokit Extension}
  spec.summary       = %q{Export issues from projects on github}
  spec.homepage      = 'https://github.com/linyows/octokit_issue_export'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'octokit', '~> 2.5.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
