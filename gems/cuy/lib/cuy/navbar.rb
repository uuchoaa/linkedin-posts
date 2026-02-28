# frozen_string_literal: true

class Cuy::Navbar < Cuy::Base
  REGISTRY = []

  def self.register(label:, path: nil, matches: nil, route_key: nil)
    REGISTRY << {
      label:     label,
      path:      path,
      matches:   matches || path,
      route_key: route_key
    }
  end

  def self.clear
    REGISTRY.clear
  end

  def self.default_orientation
    explicit = Cuy.config.layout.navbar.orientation
    return explicit if explicit && %i[horizontal vertical].include?(explicit)
    strategy = Cuy.config.layout.strategy
    strategy == :sidebar ? :vertical : :horizontal
  end

  def self.content_offset_class
    width = Cuy.config.layout.sidebar.width
    width ? "ml-#{width}" : "ml-64"
  end

  def initialize(brand: "App", current_path: nil, orientation: nil)
    @brand = brand
    @current_path = current_path
    @orientation = orientation || self.class.default_orientation
  end

  def view_template
    if @orientation == :vertical
      render_vertical
    else
      render_horizontal
    end
  end

  private

  def render_horizontal
    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center gap-6") do
        render_nav_items(link_class: "text-sm")
      end
    end
  end

  def sidebar_width_class
    width = Cuy.config.layout.sidebar.width
    width ? "w-#{width}" : "w-64"
  end

  def render_vertical
    nav(class: "fixed left-0 top-0 bottom-0 z-10 flex flex-col border-r border-gray-200 bg-white #{sidebar_width_class}") do
      div(class: "flex flex-col gap-1 p-4") do
        render_nav_items(link_class: "block rounded-lg px-3 py-2 text-sm")
      end
    end
  end

  def nav_items
    self.class::REGISTRY.map { |item| item.merge(path: item[:path]) }
  end

  def render_nav_items(link_class:)
    a(href: "/", class: "text-lg font-semibold text-gray-900") { @brand }
    nav_items.each do |item|
      next unless item[:path]
      active = @current_path&.start_with?(item[:matches].to_s)
      classes = [
        link_class,
        active ? "font-medium text-gray-900" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900"
      ].join(" ")
      a(href: item[:path], class: classes) { item[:label] }
    end
  end
end
