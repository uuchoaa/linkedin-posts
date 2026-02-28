# frozen_string_literal: true

Rails.application.config.to_prepare do
  Cuy.configure do |config|
    config.theme.primary_color = "indigo"
    config.theme.secondary_color = "gray"
    config.layout.strategy = :stacked
    config.layout.stacked.variant = :overlap
    config.layout.sidebar.width = "64"
    config.components.button[:default_variant] = :primary
  end

  Cuy::Navbar.configure do |nav|
    nav.brand "LinkedIn Posts"
    nav.section "Resources" do
      nav.resource Post
    end
  end
end
