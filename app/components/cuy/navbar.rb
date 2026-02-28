# frozen_string_literal: true

class Cuy::Navbar < Cuy::Base
  REGISTRY = []

  def self.register(model_class)
    REGISTRY << {
      label:      model_class.model_name.human(count: 2),
      route_key:  model_class.model_name.route_key,
      matches:    "/#{model_class.model_name.route_key}"
    }
  end

  def view_template
    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center gap-6") do
        a(href: "/", class: "text-lg font-semibold text-gray-900") { "LinkedIn Posts" }
        REGISTRY.each do |item|
          href   = helpers.public_send(:"#{item[:route_key]}_path")
          active = helpers.request.path.start_with?(item[:matches])
          classes = active ? "text-md font-medium text-gray-900" : "text-sm text-gray-600 hover:text-gray-900"
          a(href: href, class: classes) { item[:label] }
        end
      end
    end
  end
end
