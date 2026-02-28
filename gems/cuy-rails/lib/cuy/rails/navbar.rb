# frozen_string_literal: true

# Extend Cuy::Navbar registration to accept ActiveRecord model classes.
class Cuy::Navbar
  # Delegate to parent: class ivars aren't inherited, so configure sets Cuy::Navbar's @nav_structure.
  def self.nav_structure
    Cuy::Navbar == self ? @nav_structure : Cuy::Navbar.nav_structure
  end
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
  def initialize(brand: "App", current_path: nil, orientation: nil)
    super(brand:, current_path:, orientation:)
  end

  def nav_items
    self.class::REGISTRY.map do |item|
      path = item[:path] || (item[:route_key] && helpers.public_send(:"#{item[:route_key]}_path"))
      item.merge(path: path)
    end
  end
end
