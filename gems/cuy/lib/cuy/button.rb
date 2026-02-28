# frozen_string_literal: true

class Cuy::Button < Cuy::Base
  VARIANTS = {
    primary:   "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700",
    secondary: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300",
    danger:    "text-red-600 hover:underline",
    ghost:     "text-blue-600 hover:underline"
  }.freeze

  def initialize(variant: nil, type: :button, href: nil, method: nil, confirm: nil)
    @variant = variant || Cuy.config.components.button[:default_variant] || :primary
    @type = type
    @href = href
    @method = method
    @confirm = confirm
  end

  def view_template(&block)
    if @href
      data = {}
      data[:turbo_method] = @method if @method
      data[:turbo_confirm] = @confirm if @confirm
      a(href: @href, class: VARIANTS[@variant], data: data.presence, &block)
    else
      button(type: @type.to_s, class: VARIANTS[@variant], &block)
    end
  end
end
