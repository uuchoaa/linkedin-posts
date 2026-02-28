# frozen_string_literal: true

class Cuy::Layout < Cuy::Base
  def initialize(title: "App", sidebar: false)
    @title = title
    @sidebar_config = sidebar
    @slots = {}
    @sidebar_items = []
    @top_bar_breadcrumb = nil
    @top_bar_right = nil
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
      Phlex::HTML::StandardElements.instance_method(:main).bind(self).call(*args, **kwargs, &block)
    end
  end

  def sidebar(&block)
    @slots[:sidebar] = block
  end

  def top_bar(breadcrumb: nil, right: nil, &block)
    if block
      @slots[:top_bar] = block
    else
      @top_bar_breadcrumb = breadcrumb
      @top_bar_right = right
    end
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
        meta charset: "UTF-8"
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        title { @title }
        extra_head if respond_to?(:extra_head, true)
      end

      body class: body_classes do
        if sidebar?
          instance_eval(&@slots[:sidebar]) if @slots[:sidebar]
          div class: "flex h-screen min-h-0" do
            render Cuy::Sidebar.new(
              brand: @sidebar_brand,
              brand_suffix: @sidebar_brand_suffix,
              theme: sidebar_theme_key,
              items: @sidebar_items
            )
            div class: "flex-1 flex flex-col min-w-0 overflow-hidden" do
              render_top_bar
              main class: "flex-1 overflow-auto p-6" do
                render_slot(:main)
              end
            end
          end
        else
          div class: "flex flex-col min-h-screen" do
            render_top_bar
            main class: "flex-1 overflow-auto p-6" do
              render_slot(:main)
            end
          end
        end
        render_slot(:overlay) if @slots[:overlay]
      end
    end
  end

  def render_top_bar
    return unless @top_bar_breadcrumb || @slots[:top_bar]

    if @top_bar_breadcrumb
      render Cuy::TopBar.new(breadcrumb: @top_bar_breadcrumb, right: @top_bar_right)
    else
      # Block slot: render in Layout context so output goes to correct buffer
      header class: "flex-shrink-0 h-12 flex items-center gap-4 px-6 bg-white border-b border-gray-200" do
        render_slot(:top_bar)
      end
    end
  end

  def render_legacy_layout(block)
    doctype
    html do
      head do
        meta charset: "UTF-8"
        meta name: "viewport", content: "width=device-width,initial-scale=1"
        title { @title }
        extra_head if respond_to?(:extra_head, true)
      end
      body { plain block.call if block }
    end
  end

  def sidebar?
    @sidebar_config && @slots[:sidebar]
  end

  def sidebar_theme_key
    @sidebar_config == true ? :light : @sidebar_config.to_sym
  end

  def body_classes
    base = "text-gray-900"
    base = "flex h-screen min-h-0 bg-[#f0f0f0]" if sidebar?
    base
  end

  def render_slot(name)
    block = @slots[name]
    return unless block
    instance_eval(&block)
  end
end
