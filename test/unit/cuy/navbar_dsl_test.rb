# frozen_string_literal: true

require "test_helper"

class Cuy::NavbarDslTest < Minitest::Test
  def teardown
    Cuy::Navbar.clear
  end

  def test_builds_structure_with_brand_and_section
    Cuy::Navbar.configure do |nav|
      nav.brand "My App"
      nav.section "Resources" do
        nav.item "Dashboard", "/"
      end
    end
    struct = Cuy::Navbar.nav_structure
    assert_equal "My App", struct[:brand]
    assert_equal 1, struct[:sections].size
    assert_equal "Resources", struct[:sections].first[:label]
    assert_equal "Dashboard", struct[:sections].first[:items].first[:label]
    assert_equal "/", struct[:sections].first[:items].first[:path]
  end

  def test_builds_nested_items
    Cuy::Navbar.configure do |nav|
      nav.section "Components" do
        nav.item "Button", "/button" do
          nav.item "Default", "/button#default"
          nav.item "Variants", "/button#variants"
        end
      end
    end
    parent = Cuy::Navbar.nav_structure[:sections].first[:items].first
    assert_equal "Button", parent[:label]
    assert_equal 2, parent[:children].size
    assert_equal "Default", parent[:children][0][:label]
    assert_equal "Variants", parent[:children][1][:label]
  end

  def test_resource_adds_model_item
    Cuy::Navbar.configure do |nav|
      nav.section "Resources" do
        nav.resource Post
      end
    end
    item = Cuy::Navbar.nav_structure[:sections].first[:items].first
    assert_includes [ "Post", "Posts" ], item[:label]
    assert_equal "posts", item[:route_key]
    assert_equal "/posts", item[:matches]
  end

  def test_slot_stores_block
    Cuy::Navbar.configure do |nav|
      nav.slot(:right) { "content" }
    end
    assert Cuy::Navbar.nav_structure[:slots][:right].is_a?(Proc)
  end
end
