# frozen_string_literal: true

module Cuy::Form::Helpers
  def cuy_section(title:, description: nil, **opts, &block)
    render Cuy::Form::Section.new(title: title, description: description, **opts), &block
  end

  def cuy_grid(cols: { base: 1, sm: 6 }, gap: { x: 6, y: 8 }, **opts, &block)
    render Cuy::Form::Grid.new(cols: cols, gap: gap, **opts), &block
  end

  def cuy_actions(align: :end, gap: 6, **opts, &block)
    render Cuy::Form::Actions.new(align: align, gap: gap, **opts), &block
  end
end
