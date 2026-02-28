# frozen_string_literal: true

# Load cuy-rails views before first request (fixes Cuy::Rails::IndexView when eager_load=false)
require "cuy/rails/base"
require "cuy/rails/layout"
require "cuy/rails/navbar"
require "cuy/rails/page_view"
require "cuy/rails/index_view"

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
    nav.slot(:notifications) do
      notifications = [
        { title: "Post published", body: "Fixture Post Title was published", time: "2 min ago", url: "/posts" },
        { title: "New post ready", body: "Your draft is ready for review", time: "1 hour ago", url: "/posts" }
      ]
      render Components::NotificationsPanel.new(notifications: notifications)
    end
  end
end
