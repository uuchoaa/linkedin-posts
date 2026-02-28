# frozen_string_literal: true

module Cuy::UiHelpers
  def cuy_container(max_width: "4xl", spacing: 12, **opts, &block)
    render Cuy::Container.new(max_width: max_width, spacing: spacing, **opts), &block
  end

  def cuy_card(title: nil, padding: :normal, **opts, &block)
    render Cuy::Card.new(title: title, padding: padding, **opts), &block
  end

  def cuy_doc_section(id: nil, title: nil, description: nil, **opts, &block)
    render Cuy::Section.new(id: id, title: title, description: description, **opts), &block
  end

  def cuy_flex(wrap: false, gap: 4, **opts, &block)
    render Cuy::Flex.new(wrap: wrap, gap: gap, **opts), &block
  end

  def cuy_prose(size: :sm, &block)
    render Cuy::Prose.new(size: size), &block
  end

  def cuy_inline_code(&block)
    render Cuy::InlineCode.new, &block
  end

  def cuy_code_block(code, collapsible: true)
    render Cuy::CodeBlock.new(code, collapsible: collapsible)
  end

  def cuy_button(variant: nil, type: :button, href: nil, method: nil, confirm: nil, **opts, &block)
    render Cuy::Button.new(variant: variant, type: type, href: href, method: method, confirm: confirm, **opts), &block
  end
end
