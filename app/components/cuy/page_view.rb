# frozen_string_literal: true

# Cuy::PageView is a base class for views that need a full page structure
# (navbar + header + main + optional aside). Subclasses implement slot methods
# instead of view_template, keeping all rendering in the view's own context —
# ivars, route helpers, and render all work naturally.
#
# Usage:
#   class Views::Posts::IndexView < Cuy::PageView
#     def navbar = render Cuy::Navbar.new
#     def page_header   = render Cuy::PageHeader.new(title: "Posts")
#     def main_content
#       render Cuy::ModelTable.new(@posts)
#     end
#   end
class Cuy::PageView < Cuy::Base
  def around_template
    render Cuy::Layout.new { super }
  end

  def view_template
    navbar if respond_to?(:navbar, true)

    header(class: "container mx-auto px-5 pt-24") do
      page_header
    end if respond_to?(:page_header, true)

    main(class: "container mx-auto px-5 flex flex-col gap-6 pb-12") do
      main_content
    end if respond_to?(:main_content, true)

    aside(class: "container mx-auto px-5") do
      aside_content
    end if respond_to?(:aside_content, true)
  end
end
