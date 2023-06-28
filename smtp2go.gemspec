# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smtp2go/version'

Gem::Specification.new do |spec|
  spec.name          = "smtp2go"
  spec.version       = Smtp2go::VERSION
  spec.authors       = ["smtp2go"]
  spec.email         = ["devs@smtp2go.com"]

  spec.summary       = %q{Library for interfacing with smtp2go API}
  spec.description   = %q{Interacts directly with smtp2go's API to facilitate sending of email.}
  spec.homepage      = "https://github.com/smtp2go-oss/smtp2go-ruby.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 2.2.33'
  spec.add_development_dependency 'coveralls', '~> 0.8.19'
  spec.add_development_dependency 'guard', '~> 2.13', '>= 2.13.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.6', '>= 4.6.4'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'webmock', '~> 2.3', '>= 2.3.2'
  spec.add_runtime_dependency 'httparty', '~> 0.21.0'
end
