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
    orientation = navbar_orientation

    if orientation == :vertical
      render_vertical_layout
    else
      render_horizontal_layout
    end
  end

  def navbar_orientation
    Cuy::Navbar.default_orientation
  end

  def render_horizontal_layout
    navbar if respond_to?(:navbar, true)
    content_section(pt: "pt-24")
  end

  def render_vertical_layout
    navbar if respond_to?(:navbar, true)
    content_section(ml: Cuy::Navbar.content_offset_class)
  end

  def content_section(pt: nil, ml: nil)
    header_classes = [ "container mx-auto px-5", pt ].compact.join(" ")

    if ml
      div(class: ml) do
        header(class: header_classes) { page_header } if respond_to?(:page_header, true)
        main(class: "container mx-auto px-5 flex flex-col gap-6 pb-12") { main_content } if respond_to?(:main_content, true)
        aside(class: "container mx-auto px-5") { aside_content } if respond_to?(:aside_content, true)
      end
    else
      header(class: header_classes) { page_header } if respond_to?(:page_header, true)
      main(class: "container mx-auto px-5 flex flex-col gap-6 pb-12") { main_content } if respond_to?(:main_content, true)
      aside(class: "container mx-auto px-5") { aside_content } if respond_to?(:aside_content, true)
    end
  end
end
