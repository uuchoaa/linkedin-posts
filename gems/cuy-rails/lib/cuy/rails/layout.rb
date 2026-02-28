# frozen_string_literal: true

# Rails Layout with CSRF, assets, flash. Replaces Cuy::Layout when used in Rails.
class Cuy::Rails::Layout < Cuy::Layout
  include Phlex::Rails::Helpers::CSRFMetaTags
  include Phlex::Rails::Helpers::CSPMetaTag
  include Phlex::Rails::Helpers::StylesheetLinkTag
  include Phlex::Rails::Helpers::JavascriptImportmapTags

  def view_template(&block)
    doctype
    html do
      head do
        title { @title }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "apple-mobile-web-app-capable", content: "yes"
        meta name: "application-name", content: @title
        meta name: "mobile-web-app-capable", content: "yes"

        csrf_meta_tags
        csp_meta_tag

        link rel: "icon", href: "/icon.png", type: "image/png"
        link rel: "icon", href: "/icon.svg", type: "image/svg+xml"
        link rel: "apple-touch-icon", href: "/icon.png"

        stylesheet_link_tag "tailwind", "data-turbo-track": "reload"
        javascript_importmap_tags
      end

      body do
        render Components::FlashNotice.new(message: flash[:notice]) if defined?(Components::FlashNotice) && flash[:notice].present?
        yield
      end
    end
  end
end
