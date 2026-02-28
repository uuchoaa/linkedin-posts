# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "cuy-rails"
  s.version     = "0.1.0"
  s.authors     = [ "LinkedIn Posts" ]
  s.summary     = "Rails integration for Cuy design system"
  s.description = "AR inference, route helpers, polymorphic paths, and seamless Rails integration."
  s.files       = Dir[ "lib/**/*" ]
  s.required_ruby_version = ">= 3.0"

  s.add_dependency "cuy", "~> 0.1"
  s.add_dependency "phlex-rails", "~> 1.0"
  s.add_dependency "rails", ">= 7.0"
end
