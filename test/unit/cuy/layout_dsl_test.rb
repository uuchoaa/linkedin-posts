# frozen_string_literal: true

require "test_helper"

class Cuy::LayoutDslTest < Minitest::Test
  def test_renders_main_only_when_only_main_slot_given
    html = render_layout(sidebar: false) { |l| l.main { l.plain "Hello" } }
    assert_includes html, "Hello"
    assert_includes html, "<main"
    refute_includes html, "aside"
    refute_includes html, "<header"
  end

  def test_renders_sidebar_and_main_when_both_given
    html = render_layout do |l|
      l.sidebar { l.plain "Nav" }
      l.main { l.plain "Content" }
    end
    assert_includes html, "Nav"
    assert_includes html, "Content"
    assert_includes html, "<aside"
    assert_includes html, "<main"
  end

  def test_renders_top_bar_when_given
    html = render_layout(sidebar: false) do |l|
      l.top_bar { l.plain "Breadcrumb" }
      l.main { l.plain "Content" }
    end
    assert_includes html, "Breadcrumb"
    assert_includes html, "<header"
  end

  def test_sidebar_dark_theme_applies_dark_classes
    html = render_layout(sidebar: :dark) do |l|
      l.sidebar { l.plain "Nav" }
      l.main { l.plain "Content" }
    end
    assert_includes html, "bg-[#1e1e1e]"
    assert_includes html, "text-white"
  end

  def test_sidebar_light_theme_applies_light_classes
    html = render_layout(sidebar: :light) do |l|
      l.sidebar { l.plain "Nav" }
      l.main { l.plain "Content" }
    end
    assert_includes html, "bg-white"
    assert_includes html, "border-r"
  end

  def test_sidebar_brand_renders_brand_and_suffix
    html = render_layout(sidebar: :dark) do |l|
      l.sidebar do
        l.brand "Cuy", suffix: "DS"
      end
      l.main { l.plain "Content" }
    end
    assert_includes html, "Cuy"
    assert_includes html, "DS"
  end

  def test_sidebar_nav_section_renders_section_label_and_items
    html = render_layout(sidebar: :dark) do |l|
      l.sidebar do
        l.nav_section "Components" do
          l.nav_item "Button", "#"
        end
      end
      l.main { l.plain "Content" }
    end
    assert_includes html, "Components"
    assert_includes html, "Button"
    assert_includes html, 'href="#"'
  end

  def test_sidebar_nav_item_with_children_renders_nested_links
    html = render_layout(sidebar: :dark) do |l|
      l.sidebar do
        l.nav_section "Components" do
          l.nav_item "Button", "#" do
            l.nav_item "Default", "#default"
            l.nav_item "Variants", "#variants"
          end
        end
      end
      l.main { l.plain "Content" }
    end
    assert_includes html, "Default"
    assert_includes html, "Variants"
    assert_includes html, 'href="#default"'
    assert_includes html, 'href="#variants"'
  end

  def test_body_has_flex_h_screen_when_sidebar_present
    html = render_layout do |l|
      l.sidebar { l.plain "Nav" }
      l.main { l.plain "Content" }
    end
    assert_includes html, "flex"
    assert_includes html, "h-screen"
  end

  def test_renders_overlay_when_given
    html = render_layout(sidebar: false) do |l|
      l.main { l.plain "Content" }
      l.overlay { l.plain "Detail panel" }
    end
    assert_includes html, "Detail panel"
    assert_includes html, "Content"
  end

  def test_backward_compatible_simple_yield
    layout = Cuy::Layout.new(title: "Test")
    html = layout.call { "Simple content" }
    assert_includes html, "Simple content"
    assert_includes html, "<body"
  end

  private

  def render_layout(sidebar: true, **opts, &block)
    opts = opts.merge(sidebar: sidebar) unless opts.key?(:sidebar)
    layout = Cuy::Layout.new(title: "Test", **opts)
    layout.call(&block)
  end
end
