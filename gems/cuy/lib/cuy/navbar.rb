# frozen_string_literal: true

class Cuy::Navbar < Cuy::Base
  class DSL
    def initialize
      @brand = "App"
      @sections = []
      @slots = {}
    end

    def brand(name)
      @brand = name
    end

    def section(label, &block)
      items = []
      parent = @current_parent
      @current_parent = items
      block.call if block
      @current_parent = parent
      @sections << { type: :section, label: label, items: items }
    end

    def item(label, path_or_route = nil, route_key: nil, icon: nil, matches: nil, &block)
      path = path_or_route.is_a?(Symbol) ? nil : path_or_route
      route_key ||= path_or_route if path_or_route.is_a?(Symbol)
      children = []
      parent = @current_parent
      @current_parent = children
      block.call if block
      @current_parent = parent
      matches ||= path || "/#{route_key}" if route_key
      parent << {
        type:      :item,
        label:     label,
        path:      path,
        route_key: route_key,
        icon:      icon,
        matches:   matches,
        children:  children
      }
    end

    def slot(name, &block)
      @slots[name] = block
    end

    def resource(model_class)
      route_key = model_class.model_name.route_key
      parent = @current_parent
      return if parent.any? { |i| i[:route_key] == route_key }
      parent << {
        type:      :item,
        label:     model_class.model_name.human(count: 2),
        path:      nil,
        route_key: route_key,
        icon:      nil,
        children:  [],
        matches:   "/#{route_key}"
      }
    end

    def build
      { brand: @brand, sections: @sections, slots: @slots }
    end
  end

  REGISTRY = []

  def self.configure(&block)
    builder = DSL.new
    builder.instance_eval(&block)
    @nav_structure = builder.build
  end

  def self.nav_structure
    @nav_structure
  end

  def self.register(label:, path: nil, matches: nil, route_key: nil)
    REGISTRY << {
      label:     label,
      path:      path,
      matches:   matches || path,
      route_key: route_key
    }
  end

  def self.clear
    REGISTRY.clear
    @nav_structure = nil
  end

  def self.default_orientation
    explicit = Cuy.config.layout.navbar.orientation
    return explicit if explicit && %i[horizontal vertical].include?(explicit)
    strategy = Cuy.config.layout.strategy
    strategy == :sidebar ? :vertical : :horizontal
  end

  def self.content_offset_class
    width = Cuy.config.layout.sidebar.width
    width ? "ml-#{width}" : "ml-64"
  end

  def initialize(brand: nil, current_path: nil, orientation: nil)
    @brand = brand || self.class.nav_structure&.dig(:brand) || "App"
    @current_path = current_path
    @orientation = orientation || self.class.default_orientation
  end

  def view_template
    if @orientation == :vertical
      render_vertical
    else
      render_horizontal
    end
  end

  private

  def nav_structure
    self.class.nav_structure
  end

  def use_dsl?
    nav_structure && nav_structure[:sections].any?
  end

  def primary_color
    color = Cuy.config.theme.primary_color
    color ? color.to_s : "indigo"
  end

  def render_horizontal
    nav(class: "fixed top-0 inset-x-0 z-10 bg-white border-b border-gray-200") do
      div(class: "container mx-auto flex h-16 items-center justify-between gap-6 px-5") do
        div(class: "flex items-center gap-6") do
          a(href: "/", class: "text-lg font-semibold text-gray-900") { @brand }
          if use_dsl?
            render_dsl_items_horizontal
          else
            render_legacy_items_horizontal
          end
        end
        render_slot(:right) if use_dsl? && nav_structure[:slots][:right]
      end
    end
  end

  def render_vertical
    nav(class: "fixed left-0 top-0 bottom-0 z-10 flex flex-col border-r border-gray-200 bg-white #{sidebar_width_class}") do
      div(class: "flex flex-1 flex-col gap-1 overflow-y-auto p-4") do
        a(href: "/", class: "mb-4 text-lg font-semibold text-gray-900") { @brand }
        if use_dsl?
          nav_structure[:sections].each { |sect| render_section_vertical(sect) }
        else
          render_legacy_items_vertical
        end
      end
      render_slot(:bottom) if use_dsl? && nav_structure[:slots][:bottom]
    end
  end

  def render_slot(name)
    block = nav_structure[:slots][name]
    return unless block
    wrapper_class = name == :bottom ? "border-t border-gray-200 p-4" : nil
    div(class: wrapper_class) { instance_eval(&block) }
  end

  def render_section_vertical(section)
    div(class: "mb-4") do
      div(class: "mb-2 px-3 text-xs font-semibold uppercase tracking-wider text-gray-500") { section[:label] }
      section[:items].each { |item| render_item_vertical(item) }
    end
  end

  def render_item_vertical(item, depth: 0)
    path = resolve_path(item)
    active = item_active?(item, path)
    has_children = item[:children].any?

    if has_children
      render_expandable_item_vertical(item, path, active, depth)
    else
      render_link_vertical(item[:label], path, active, depth, item[:icon])
    end
  end

  def render_expandable_item_vertical(item, path, active, depth)
    child_active = item[:children].any? { |c| item_active?(c, resolve_path(c)) }
    open_attr = child_active ? { open: true } : {}
    pl = depth.zero? ? "pl-0" : "pl-6"

    details(**open_attr, class: "group") do
      summary(class: "flex list-none cursor-pointer items-center gap-2 rounded-lg px-3 py-2 text-sm hover:bg-gray-100 [&::-webkit-details-marker]:hidden") do
        a(href: path, class: "flex flex-1 items-center gap-2 #{active ? "font-medium text-#{primary_color}-600" : "text-gray-600"} hover:text-gray-900", onclick: "event.stopPropagation()") do
          render_icon(item[:icon]) if item[:icon]
          plain item[:label]
        end
        button(type: "button", class: "shrink-0 rounded p-0.5 text-gray-400 transition-transform hover:bg-gray-200 group-open:rotate-180", onclick: "this.closest('details').toggleAttribute('open'); event.preventDefault()") { chevron_down_svg }
      end
      div(class: "#{pl} mt-1") do
        item[:children].each { |c| render_item_vertical(c, depth: depth + 1) }
      end
    end
  end

  def render_link_vertical(label, path, active, depth, icon = nil)
    return unless path
    pl = depth.zero? ? "" : "pl-6"
    link_class = [
      "flex items-center gap-2 rounded-lg px-3 py-2 text-sm",
      pl,
      active ? "font-medium bg-#{primary_color}-50 text-#{primary_color}-600" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900"
    ].compact.join(" ")
    a(href: path, class: link_class) do
      render_icon(icon) if icon
      plain label
    end
  end

  def render_dsl_items_horizontal
    nav_structure[:sections].flat_map { |s| s[:items] }.each { |item| render_item_horizontal(item) }
  end

  def render_item_horizontal(item)
    path = resolve_path(item)
    active = item_active?(item, path)
    has_children = item[:children].any?

    if has_children
      div(class: "relative group/dd") do
        a(href: path, class: "flex items-center gap-1 rounded px-2 py-1 text-sm #{active ? "font-medium text-#{primary_color}-600 border-b-2 border-#{primary_color}-600" : "text-gray-600 hover:text-gray-900"}") do
          plain item[:label]
          span(class: "text-gray-400") { chevron_down_svg }
        end
        div(class: "absolute left-0 top-full hidden min-w-48 rounded-lg border border-gray-200 bg-white py-1 shadow-lg group-hover/dd:block") do
          item[:children].each do |c|
            child_path = resolve_path(c)
            next unless child_path
            a(href: child_path, class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-gray-900") { c[:label] }
          end
        end
      end
    else
      a(href: path, class: "rounded px-2 py-1 text-sm #{active ? "font-medium text-#{primary_color}-600 border-b-2 border-#{primary_color}-600" : "text-gray-600 hover:text-gray-900"}") { item[:label] } if path
    end
  end

  def render_legacy_items_horizontal
    nav_items.each do |item|
      next unless item[:path]
      active = @current_path&.start_with?(item[:matches].to_s)
      a(href: item[:path], class: "rounded px-2 py-1 text-sm #{active ? "font-medium text-#{primary_color}-600 border-b-2 border-#{primary_color}-600" : "text-gray-600 hover:text-gray-900"}") { item[:label] }
    end
  end

  def render_legacy_items_vertical
    nav_items.each do |item|
      next unless item[:path]
      active = @current_path&.start_with?(item[:matches].to_s)
      a(href: item[:path], class: "block rounded-lg px-3 py-2 text-sm #{active ? "font-medium bg-#{primary_color}-50 text-#{primary_color}-600" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900"}") { item[:label] }
    end
  end

  def render_icon(name)
    span(class: "inline-flex size-5 shrink-0", data: { icon: name }) do
      icon_svg(name)
    end
  end

  def icon_svg(name)
    paths = {
      house: "M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25",
      folder: "M2.25 12.75V12A2.25 2.25 0 014.5 9.75h15A2.25 2.25 0 0121.75 12v.75m-8.69-6.348l-1.44 1.44c1.2 1.2 1.872 2.798 1.872 4.48 0 3.315-2.687 6-6 6s-6-2.685-6-6c0-1.682.652-3.282 1.872-4.48l-1.44-1.44M4.5 19.5h15a2.25 2.25 0 002.25-2.25V6A2.25 2.25 0 0019.5 3.75h-15a2.25 2.25 0 00-2.25 2.25v11.25A2.25 2.25 0 004.5 19.5z",
      users: "M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.33 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z",
      calendar: "M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5",
      document: "M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z",
      chart: "M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"
    }
    return unless paths[name.to_sym]
    svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-5") do
      path(stroke_linecap: "round", stroke_linejoin: "round", d: paths[name.to_sym])
    end
  end

  def chevron_down_svg
    svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-4") do
      path(stroke_linecap: "round", stroke_linejoin: "round", d: "M19.5 8.25l-7.5 7.5-7.5-7.5")
    end
  end

  def resolve_path(item)
    item[:path] || (item[:route_key] && try_route_path(item[:route_key]))
  end

  def try_route_path(route_key)
    respond_to?(:helpers) && helpers.respond_to?(:"#{route_key}_path") ? helpers.public_send(:"#{route_key}_path") : nil
  end

  def item_active?(item, path)
    return false unless @current_path && path
    matches = item[:matches] || path
    @current_path.start_with?(matches.to_s) || @current_path == path
  end

  def nav_items
    self.class::REGISTRY.map { |item| item.merge(path: item[:path]) }
  end

  def sidebar_width_class
    width = Cuy.config.layout.sidebar.width
    width ? "w-#{width}" : "w-64"
  end
end
