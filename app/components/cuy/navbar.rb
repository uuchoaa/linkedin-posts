# frozen_string_literal: true

class Cuy::Navbar < Cuy::Base
  def view_template
    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto px-5 h-16 flex items-center") do
        a(href: "/", class: "text-lg font-semibold text-gray-900") { "LinkedIn Posts" }
      end
    end
  end
end
