# frozen_string_literal: true

class Cuy::Button < Cuy::Base
  VARIANTS = {
    primary: "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700",
    secondary: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300",
    danger: "text-red-600 hover:underline",
    ghost: "text-blue-600 hover:underline"
  }.freeze

  def initialize(variant: :primary, href: nil, **attrs)
    @variant = variant
    @href = href
    @attrs = attrs
  end

  def view_template(&block)
    if @href
      a(href: @href, class: VARIANTS[@variant], **@attrs, &block)
    else
      button(type: "button", class: VARIANTS[@variant], **@attrs, &block)
    end
  end
end
