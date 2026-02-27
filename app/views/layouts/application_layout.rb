class Views::Layouts::ApplicationLayout < Views::Base
  def template(&block)
    doctype
    html do
      head do
        title { content_for?(:title) ? content_for(:title) : "Linkedin Posts" }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        meta name: "apple-mobile-web-app-capable", content: "yes"
        meta name: "application-name", content: "Linkedin Posts"
        meta name: "mobile-web-app-capable", content: "yes"

        csrf_meta_tags
        csp_meta_tag

        content_for(:head) if content_for?(:head)

        link rel: "icon", href: "/icon.png", type: "image/png"
        link rel: "icon", href: "/icon.svg", type: "image/svg+xml"
        link rel: "apple-touch-icon", href: "/icon.png"

        stylesheet_link_tag :app, data: { turbo_track: "reload" }
        javascript_importmap_tags
      end

      body do
        main(class: "container mx-auto mt-28 px-5 flex flex-col") do
          render Components::FlashNotice.new(message: flash[:notice]) if flash[:notice].present?
          block&.call
        end
      end
    end
  end
end
