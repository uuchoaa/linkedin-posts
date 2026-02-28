# frozen_string_literal: true

# Extend Cuy::Navbar registration to accept ActiveRecord model classes.
class Cuy::Navbar
  def self.register(model_class = nil, **kwargs)
    if model_class && kwargs.empty?
      register_model(model_class)
    elsif kwargs[:label]
      REGISTRY << {
        label:     kwargs[:label],
        path:      kwargs[:path],
        matches:   kwargs[:matches] || kwargs[:path],
        route_key: kwargs[:route_key]
      }
    end
  end

  def self.register_model(model_class)
    route_key = model_class.model_name.route_key
    return if REGISTRY.any? { |r| r[:route_key] == route_key }

    register(
      label:     model_class.model_name.human(count: 2),
      route_key: route_key,
      matches:   "/#{route_key}"
    )
  end
end

# Rails-aware Navbar that resolves paths via route helpers.
class Cuy::Rails::Navbar < Cuy::Navbar
  def initialize(brand: "App", current_path: nil)
    super(brand:, current_path:)
  end

  def view_template
    items = self.class::REGISTRY.map do |item|
      path = item[:path] || (item[:route_key] && helpers.public_send(:"#{item[:route_key]}_path"))
      item.merge(path: path)
    end

    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center gap-6") do
        a(href: "/", class: "text-lg font-semibold text-gray-900") { @brand }
        items.each do |item|
          next unless item[:path]
          active = @current_path&.start_with?(item[:matches].to_s)
          classes = active ? "text-md font-medium text-gray-900" : "text-sm text-gray-600 hover:text-gray-900"
          a(href: item[:path], class: classes) { item[:label] }
        end
      end
    end
  end
end
