# frozen_string_literal: true

class Cuy::Layout < Cuy::Base
  SIDEBAR_THEMES = {
    dark: {
      container: "flex-shrink-0 bg-[#1e1e1e] text-white",
      brand: "text-lg font-bold",
      brand_suffix: "text-xs text-gray-400 font-mono",
      section: "text-[10px] uppercase tracking-wider text-gray-500 px-3 py-2",
      item: "flex items-center gap-2 px-3 py-2 rounded text-sm hover:bg-white/5",
      item_active: "bg-white/10",
      item_child: "block px-3 py-1.5 rounded text-xs text-gray-400 hover:text-white hover:bg-white/5"
    },
    light: {
      container: "flex-shrink-0 bg-white border-r border-gray-200 text-gray-900",
      brand: "text-lg font-semibold",
      brand_suffix: "text-xs text-gray-500 font-mono",
      section: "text-xs font-semibold uppercase tracking-wider text-gray-500 px-3 py-2",
      item: "flex items-center gap-2 px-3 py-2 rounded text-sm hover:bg-gray-100",
      item_active: "font-medium bg-gray-100",
      item_child: "block pl-6 py-2 rounded text-sm text-gray-600 hover:bg-gray-50 hover:text-gray-900"
    }
  }.freeze

  def initialize(title: "App", sidebar: false)
    @title = title
    @sidebar_config = sidebar
    @slots = {}
    @sidebar_items = []
  end

  def view_template(&block)
    return render_legacy_layout(block) unless block

    block.call(self)
    if @slots.any?
      render_dsl_layout
    else
      render_legacy_layout(block)
    end
  end

  def main(*args, **kwargs, &block)
    if args.empty? && kwargs.empty? && block_given?
      @slots[:main] = block
    else
      # Delegate to Phlex's HTML <main> element (we override it)
      Phlex::HTML::StandardElements.instance_method(:main).bind(self).call(*args, **kwargs, &block)
    end
  end

  def sidebar(&block)
    @slots[:sidebar] = block
  end

  def top_bar(&block)
    @slots[:top_bar] = block
  end

  def overlay(&block)
    @slots[:overlay] = block
  end

  def brand(text, suffix: nil)
    @sidebar_brand = text
    @sidebar_brand_suffix = suffix
  end

  def nav_section(label, &block)
    items = []
    @_nav_parent = items
    block.call if block
    @sidebar_items << { type: :section, label: label, items: items }
  end

  def nav_item(label, path = "#", active: false, &block)
    children = []
    parent = @_nav_parent
    if block
      @_nav_parent = children
      block.call
      @_nav_parent = parent
    end
    (parent ||= []) << { type: :item, label: label, path: path, active: active, children: children }
  end

  private

  def render_dsl_layout
    doctype
    html do
      head do
        title { @title }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
      end

      body(class: body_classes) do
        if sidebar?
          div(class: "flex h-screen min-h-0") do
            render_sidebar
            div(class: "flex-1 flex flex-col min-w-0 overflow-hidden") do
              header { render_slot(:top_bar) } if @slots[:top_bar]
              main(class: main_classes) { render_slot(:main) }
            end
          end
        else
          div(class: "flex flex-col min-h-screen") do
            header { render_slot(:top_bar) } if @slots[:top_bar]
            main(class: main_classes) { render_slot(:main) }
          end
        end
        render_slot(:overlay) if @slots[:overlay]
      end
    end
  end

  def render_legacy_layout(block)
    doctype
    html do
      head do
        title { @title }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
      end
      body { plain block.call if block }
    end
  end

  def sidebar?
    @sidebar_config && @slots[:sidebar]
  end

  def body_classes
    base = "text-gray-900"
    base = "flex h-screen min-h-0 bg-[#f0f0f0]" if sidebar?
    base
  end

  def main_classes
    "flex-1 overflow-auto p-6"
  end

  def render_sidebar
    instance_eval(&@slots[:sidebar]) if @slots[:sidebar]

    theme = sidebar_theme
    width = sidebar_width
    border_class = theme[:container].include?("1e1e1e") ? "border-white/10" : "border-gray-200"
    aside(class: "#{width} #{theme[:container]}") do
      if @sidebar_brand || @sidebar_items.any?
        div(class: "p-4 border-b #{border_class}") do
          div(class: "flex items-center gap-2") do
            span(class: theme[:brand]) { @sidebar_brand } if @sidebar_brand
            span(class: theme[:brand_suffix]) { @sidebar_brand_suffix } if @sidebar_brand_suffix
          end
        end
      end
      nav(class: "p-2") { render_sidebar_nav(theme) }
    end
  end

  def render_sidebar_nav(theme)
    @sidebar_items.each do |entry|
      if entry[:type] == :section
        div(class: theme[:section]) { entry[:label] }
        entry[:items].each { |item| render_nav_item(item, theme) }
      end
    end
  end

  def render_nav_item(item, theme)
    if item[:children].any?
      a(href: item[:path], class: "#{theme[:item]} #{item[:active] ? theme[:item_active] : ''}") { item[:label] }
      div(class: "pl-4 mt-1 space-y-0.5") do
        item[:children].each do |child|
          a(href: child[:path], class: theme[:item_child]) { child[:label] }
        end
      end
    else
      a(href: item[:path], class: "#{theme[:item]} #{item[:active] ? theme[:item_active] : ''}") { item[:label] }
    end
  end

  def sidebar_theme
    key = @sidebar_config == true ? :light : @sidebar_config.to_sym
    SIDEBAR_THEMES[key] || SIDEBAR_THEMES[:light]
  end

  def sidebar_width
    "w-60"
  end

  def render_slot(name)
    block = @slots[name]
    return unless block
    instance_eval(&block)
  end
end
