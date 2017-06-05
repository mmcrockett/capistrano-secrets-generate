# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/secrets_generate/version"

Gem::Specification.new do |gem|
  gem.name          = "capistrano-secrets-generate"
  gem.version       = Capistrano::SecretsGenerate::VERSION
  gem.authors       = ["Mike Crockett"]
  gem.email         = ["rubygems@mmcrockett.com"]
  gem.description   = <<-EOF.gsub(/^\s+/, "")
    Capistrano tasks for automating generating or linking a secret in Rails 4+.

    This plugin generates a secret if one doesn't exist on a remote server.

    If a secret is already found on remote server, then it copies to shared
    location and links.
  EOF
  gem.summary       = "Capistrano tasks for automating generating/linking a secret."
  gem.homepage      = "https://github.com/mmcrockett/capistrano-secrets-generate"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.licenses      = ['MIT']

  gem.add_dependency "capistrano", "~> 3.1"
  gem.add_development_dependency "rake", "~> 0"
end
