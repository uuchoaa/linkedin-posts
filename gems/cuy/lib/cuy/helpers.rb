# frozen_string_literal: true

module Cuy::Helpers
  include Cuy::Form::Helpers
  include Cuy::UiHelpers
end

Cuy::Base.include(Cuy::Helpers)
