# frozen_string_literal: true

class Components::NotificationsPanel < Components::Base
  def initialize(notifications: [], empty_message: "No notifications")
    @notifications = notifications
    @empty_message = empty_message
  end

  def view_template
    div(class: "relative group") do
      button(
        type: "button",
        class: "relative rounded-lg p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500",
        aria: { haspopup: "true", expanded: "false" }
      ) do
        render_bell_icon
        render_badge if @notifications.any?
      end
      div(
        class: "absolute right-0 top-full z-50 mt-1 min-w-80 overflow-hidden rounded-lg border border-gray-200 bg-white shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-opacity"
      ) do
        render_panel_header
        div(class: "max-h-96 overflow-y-auto") do
          if @notifications.empty?
            div(class: "px-4 py-8 text-center text-sm text-gray-500") { @empty_message }
          else
            ul(class: "divide-y divide-gray-100") do
              @notifications.each { |n| render_notification(n) }
            end
          end
        end
      end
    end
  end

  private

  def render_bell_icon
    svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-5") do |s|
      s.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75v-.7V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0")
    end
  end

  def render_badge
    span(
      class: "absolute -right-0.5 -top-0.5 flex size-4 items-center justify-center rounded-full bg-red-500 text-[10px] font-medium text-white",
      aria: { hidden: "true" }
    ) { @notifications.size > 9 ? "9+" : @notifications.size }
  end

  def render_panel_header
    div(class: "border-b border-gray-100 px-4 py-3") do
      h3(class: "text-sm font-semibold text-gray-900") { "Notifications" }
    end
  end

  def render_notification(notification)
    url = notification[:url] || notification["url"] || "#"
    title = notification[:title] || notification["title"] || "Notification"
    body = notification[:body] || notification["body"]
    time = notification[:time] || notification["time"]

    li do
      a(href: url, class: "block px-4 py-3 hover:bg-gray-50") do
        div(class: "text-sm font-medium text-gray-900") { title }
        div(class: "text-sm text-gray-500") { body } if body.present?
        div(class: "mt-1 text-xs text-gray-400") { time } if time.present?
      end
    end
  end
end
