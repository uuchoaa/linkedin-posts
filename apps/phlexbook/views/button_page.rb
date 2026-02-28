# frozen_string_literal: true

class Phlexbook::ButtonPage < Phlex::HTML
  def view_template
    render Phlexbook::Layout.new(title: "Cuy – Storybook", sidebar: :dark) do |l|
      l.sidebar do
        l.brand "Cuy", suffix: "DS"
        l.nav_section "Components" do
          l.nav_item "Button", "#", active: true do
            l.nav_item "Default", "#default"
            l.nav_item "Variants", "#variants"
            l.nav_item "As link", "#as-link"
          end
        end
      end
      l.top_bar breadcrumb: [ "Components", "Button" ], right: "Phlex component"
      l.main do
        render Phlexbook::ButtonPageContent.new
      end
    end
  end
end

class Phlexbook::ButtonPageContent < Phlex::HTML
  def view_template
    render Cuy::Container.new(max_width: "4xl", spacing: 12) do
      render Cuy::Card.new(title: "Overview") do
        render Cuy::Prose.new do
          p do
            plain "Primary actions and links. Use "
            render Cuy::InlineCode.new { plain "variant" }
            plain " for style, "
            render Cuy::InlineCode.new { plain "href" }
            plain " to render as a link."
          end
          p { plain "Add your documentation here." }
        end
      end
      render Cuy::Section.new(id: "default", title: "Default", description: "Base button, primary variant.") do
        render Cuy::Card.new(padding: :large) do
          render Cuy::Button.new { "Save" }
        end
        render Cuy::CodeBlock.new('render Cuy::Button.new { "Save" }')
      end
      render Cuy::Section.new(id: "variants", title: "Variants", description: "primary, secondary, danger, ghost.") do
        render Cuy::Card.new(padding: :large) do
          render Cuy::Flex.new(wrap: true, gap: 4) do
            render Cuy::Button.new(variant: :primary) { "Primary" }
            render Cuy::Button.new(variant: :secondary) { "Secondary" }
            render Cuy::Button.new(variant: :danger, href: "#") { "Danger" }
            render Cuy::Button.new(variant: :ghost, href: "#") { "Ghost" }
          end
        end
        render Cuy::CodeBlock.new(<<~RUBY.strip)
          render Cuy::Button.new(variant: :primary) { "Primary" }
          render Cuy::Button.new(variant: :secondary) { "Secondary" }
          render Cuy::Button.new(variant: :danger) { "Danger" }
          render Cuy::Button.new(variant: :ghost) { "Ghost" }
        RUBY
      end
      render Cuy::Section.new(id: "as-link", title: "As link", description: "Pass href to render an anchor. Supports method and confirm for Turbo.") do
        render Cuy::Card.new(padding: :large) do
          render Cuy::Flex.new(wrap: true, gap: 4) do
            render Cuy::Button.new(variant: :primary, href: "/posts") { "New Post" }
            render Cuy::Button.new(variant: :secondary, href: "/posts/1") { "Edit" }
            render Cuy::Button.new(variant: :ghost, href: "/posts/1") { "Show" }
            render Cuy::Button.new(variant: :danger, href: "/posts/1", method: :delete, confirm: "Are you sure?") { "Delete" }
          end
        end
        render Cuy::CodeBlock.new(<<~RUBY.strip)
          render Cuy::Button.new(variant: :primary, href: new_post_path) { "New Post" }
          render Cuy::Button.new(variant: :danger, href: post_path(@post), method: :delete, confirm: "Are you sure?") { "Delete" }
        RUBY
      end
    end
  end
end
