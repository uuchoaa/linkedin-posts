# frozen_string_literal: true

# Base class for full-page views (navbar + header + main). Subclasses implement
# slot methods: navbar, page_header, main_content, aside_content.
class Cuy::PageView < Cuy::Base
  def around_template
    render Cuy::Layout.new(title: layout_title) { super }
  end

  def layout_title
    "App"
  end

  def navbar
    render Cuy::Navbar.new(brand: layout_title, current_path: current_path)
  end

  def current_path
    nil
  end

  def view_template
    navbar if respond_to?(:navbar, true)

    if respond_to?(:page_header, true)
      header(class: "container mx-auto px-5 pt-24") { page_header }
    end

    if respond_to?(:main_content, true)
      main(class: "container mx-auto px-5 flex flex-col gap-6 pb-12") { main_content }
    end

    if respond_to?(:aside_content, true)
      aside(class: "container mx-auto px-5") { aside_content }
    end
  end
end
