# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "cuy"
  s.version     = "0.1.0"
  s.authors     = [ "LinkedIn Posts" ]
  s.summary     = "Design system with Phlex components"
  s.description = "Framework-agnostic component library producing HTML. Use with Sinatra, Rack, or cuy-rails."
  s.files       = Dir[ "lib/**/*" ]
  s.required_ruby_version = ">= 3.0"

  s.add_dependency "phlex", "~> 1.0"
end
