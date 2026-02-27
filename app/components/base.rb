# frozen_string_literal: true

class Components::Base < Phlex::HTML
  # Shared helpers for all components/views
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::AssetTag
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::CSRF
  include Phlex::Rails::Helpers::CSP
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Tag
  include Phlex::Rails::Helpers::Turbo

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
