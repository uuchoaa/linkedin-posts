# frozen_string_literal: true

# Cuy::Page provides the structural HTML shell (navbar + main + aside).
# Consumers render it and call with_* methods from within the block.
# Phlex yields `self` automatically, so blocks execute in Cuy::Page context.
# Use `render ComponentClass.new` — Phlex's buffer routing handles output correctly.
class Cuy::Page < Cuy::Base
  def view_template(&)
    render Cuy::Layout.new { yield }
  end

  def with_navbar(&)
    nav(&)
  end

  def with_header(&)
    header(class: "container mx-auto px-5 pt-8", &)
  end

  def with_main(&)
    main(class: "container mx-auto px-5 flex flex-col gap-6 pb-12", &)
  end

  def with_aside(&)
    aside(class: "container mx-auto px-5", &)
  end
end
