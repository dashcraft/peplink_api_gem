# frozen_string_literal: true

require_relative "lib/peplink_api/version"

Gem::Specification.new do |spec|
  spec.name          = "peplink_api"
  spec.version       = PeplinkApi::VERSION
  spec.authors       = ["Daniel Ashcraft"]
  spec.email         = ["daniel.ashcraft@ofashandfire.com"]

  spec.summary       = "An API wrapper for the peplink api."
  spec.description   = "The peplink api is a tad cumbersome, this attempt to expose all of the endpoints as well as some more helpful methods as well."
  spec.homepage      = "https://www.ofashandfire.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "www.ofashandfire.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/dashcraft/peplink_api_gem"
  spec.metadata["changelog_uri"] = "https://github.com/dashcraft/peplink_api_gem"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 1.7"
  spec.add_dependency "faraday_middleware", "~> 1.1"


  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
