# frozen_string_literal: true

class Cuy::Sidebar < Cuy::Base
  THEMES = {
    dark: {
      container: "flex-shrink-0 bg-[#1e1e1e] text-white w-60",
      brand: "text-lg font-bold",
      brand_suffix: "text-xs text-gray-400 font-mono",
      section: "text-[10px] uppercase tracking-wider text-gray-500 px-3 py-2",
      item: "flex items-center gap-2 px-3 py-2 rounded text-sm hover:bg-white/5",
      item_active: "bg-white/10",
      item_child: "block px-3 py-1.5 rounded text-xs text-gray-400 hover:text-white hover:bg-white/5",
      border: "border-white/10"
    },
    light: {
      container: "flex-shrink-0 bg-white border-r border-gray-200 text-gray-900 w-60",
      brand: "text-lg font-semibold",
      brand_suffix: "text-xs text-gray-500 font-mono",
      section: "text-xs font-semibold uppercase tracking-wider text-gray-500 px-3 py-2",
      item: "flex items-center gap-2 px-3 py-2 rounded text-sm hover:bg-gray-100",
      item_active: "font-medium bg-gray-100",
      item_child: "block pl-6 py-2 rounded text-sm text-gray-600 hover:bg-gray-50 hover:text-gray-900",
      border: "border-gray-200"
    }
  }.freeze

  def initialize(brand: nil, brand_suffix: nil, theme: :dark, items: [])
    @brand = brand
    @brand_suffix = brand_suffix
    @theme = THEMES[theme.to_sym] || THEMES[:light]
    @items = items
  end

  def view_template
    aside class: @theme[:container] do
      render_brand if @brand || @items.any?
      nav class: "p-2" do
        @items.each { |entry| render_entry(entry) }
      end
    end
  end

  private

  def render_brand
    div class: "p-4 border-b #{@theme[:border]}" do
      div class: "flex items-center gap-2" do
        span(class: @theme[:brand]) { plain @brand } if @brand
        span(class: @theme[:brand_suffix]) { plain @brand_suffix } if @brand_suffix
      end
    end
  end

  def render_entry(entry)
    return unless entry[:type] == :section

    div(class: @theme[:section]) { plain entry[:label] }
    entry[:items].each { |item| render_nav_item(item) }
  end

  def render_nav_item(item)
    if item[:children].any?
      a href: item[:path], class: "#{@theme[:item]} #{item[:active] ? @theme[:item_active] : ''}" do
        plain item[:label]
      end
      div class: "pl-4 mt-1 space-y-0.5" do
        item[:children].each do |child|
          a href: child[:path], class: @theme[:item_child] do
            plain child[:label]
          end
        end
      end
    else
      a href: item[:path], class: "#{@theme[:item]} #{item[:active] ? @theme[:item_active] : ''}" do
        plain item[:label]
      end
    end
  end
end
