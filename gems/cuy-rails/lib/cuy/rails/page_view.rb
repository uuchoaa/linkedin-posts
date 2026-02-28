# frozen_string_literal: true

# Rails PageView with Layout, Navbar, and request context.
class Cuy::Rails::PageView < Cuy::PageView
  def around_template
    render Cuy::Rails::Layout.new(title: layout_title) { super }
  end

  def current_path
    helpers.request.path
  end

  def navbar
    render Cuy::Rails::Navbar.new(brand: layout_title, current_path:)
  end
end
