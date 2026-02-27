# frozen_string_literal: true

class Cuy::Navbar < Cuy::Base
  def initialize
    @items = []
  end

  def view_template(&)
    vanish(&) if block_given?

    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center gap-6") do
        a(href: "/", class: "text-lg font-semibold text-gray-900") { "LinkedIn Posts" }
        @items.each do |i|
          classes = i[:active] ? "text-sm font-medium text-gray-900" : "text-sm text-gray-600 hover:text-gray-900"
          a(href: i[:href], class: classes) { i[:label] }
        end
      end
    end
  end

  def item(label, href:, active: false)
    @items << { label:, href:, active: }
    nil
  end
end
