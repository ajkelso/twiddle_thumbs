require_relative 'lib/twiddle_thumbs/version'

Gem::Specification.new do |spec|
  spec.name          = "twiddle_thumbs"
  spec.version       = TwiddleThumbs::VERSION
  spec.authors       = ["ajkelso"]
  spec.email         = ["ajkelso@gmail.com"]

  spec.summary       = %q{"This app will help fix your boredom problems."}
  spec.description   = %q{"This CLI app uses boredapi.com to give users activity suggestions."}
  spec.homepage      = "https://github.com/ajkelso/twiddle_thumbs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ajkelso/twiddle_thumbs"
  spec.metadata["changelog_uri"] = "https://github.com/ajkelso/twiddle_thumbs/commits/master"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "colorize"
  


end
