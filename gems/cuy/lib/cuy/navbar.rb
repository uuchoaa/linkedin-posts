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

  def initialize(brand: "App", current_path: nil)
    @brand = brand
    @current_path = current_path
  end

  def view_template
    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center gap-6") do
        a(href: "/", class: "text-lg font-semibold text-gray-900") { @brand }
        REGISTRY.each do |item|
          active = @current_path&.start_with?(item[:matches])
          classes = active ? "text-md font-medium text-gray-900" : "text-sm text-gray-600 hover:text-gray-900"
          a(href: item[:path], class: classes) { item[:label] }
        end
      end
    end
  end
end
