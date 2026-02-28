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
      l.top_bar breadcrumb: [ "Components", "Button" ], right: "Helper: #{Cuy::Button.cuy_helper_names.join(", ")}"
      l.main do
        render Phlexbook::ButtonPageContent.new
      end
    end
  end
end

class Phlexbook::ButtonPageContent < Cuy::Base
  def view_template
    cuy_container(max_width: "4xl", spacing: 12) do
      cuy_card(title: "Overview") do
        cuy_prose do
          p do
            plain "Primary actions and links. Use "
            cuy_inline_code { plain "variant" }
            plain " for style, "
            cuy_inline_code { plain "href" }
            plain " to render as a link."
          end
          render Phlexbook::HelperRegistrationDisplay.new(Cuy::Button)
          p { plain "Add your documentation here." }
        end
      end
      cuy_doc_section(id: "default", title: "Default", description: "Base button, primary variant.") do
        cuy_card(padding: :large) do
          cuy_button { "Save" }
        end
        cuy_code_block('cuy_button { "Save" }')
      end
      cuy_doc_section(id: "variants", title: "Variants", description: "primary, secondary, danger, ghost.") do
        cuy_card(padding: :large) do
          cuy_flex(wrap: true, gap: 4) do
            cuy_button(variant: :primary) { "Primary" }
            cuy_button(variant: :secondary) { "Secondary" }
            cuy_button(variant: :danger, href: "#") { "Danger" }
            cuy_button(variant: :ghost, href: "#") { "Ghost" }
          end
        end
        cuy_code_block(<<~RUBY.strip)
          cuy_button(variant: :primary) { "Primary" }
          cuy_button(variant: :secondary) { "Secondary" }
          cuy_button(variant: :danger) { "Danger" }
          cuy_button(variant: :ghost) { "Ghost" }
        RUBY
      end
      cuy_doc_section(id: "as-link", title: "As link", description: "Pass href to render an anchor. Supports method and confirm for Turbo.") do
        cuy_card(padding: :large) do
          cuy_flex(wrap: true, gap: 4) do
            cuy_button(variant: :primary, href: "/posts") { "New Post" }
            cuy_button(variant: :secondary, href: "/posts/1") { "Edit" }
            cuy_button(variant: :ghost, href: "/posts/1") { "Show" }
            cuy_button(variant: :danger, href: "/posts/1", method: :delete, confirm: "Are you sure?") { "Delete" }
          end
        end
        cuy_code_block(<<~RUBY.strip)
          cuy_button(variant: :primary, href: new_post_path) { "New Post" }
          cuy_button(variant: :danger, href: post_path(@post), method: :delete, confirm: "Are you sure?") { "Delete" }
        RUBY
      end
    end
  end
end
