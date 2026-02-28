# frozen_string_literal: true

class Cuy::Form::Actions < Cuy::Base
  cuy_helper :cuy_actions

  ALIGN = {
    start:   "justify-start",
    end:     "justify-end",
    center:  "justify-center",
    between: "justify-between"
  }.freeze

  def initialize(align: :end, gap: 6, **html_options)
    @align = align
    @gap = gap
    @html_options = html_options
  end

  def view_template(&block)
    div(
      class: "mt-6 flex items-center #{ALIGN[@align]} gap-x-#{@gap}",
      **@html_options
    ) do
      yield ActionsBuilder.new(self)
    end
  end

  def button(text, type: :button, variant: :primary, **opts)
    render Cuy::Button.new(type:, variant:, **opts) { text }
  end

  def cancel(text = "Cancel", **opts)
    render Cuy::Button.new(type: :button, variant: :ghost, **opts) { text }
  end

  def submit(text = "Save", **opts)
    render Cuy::Button.new(type: :submit, variant: :primary, **opts) { text }
  end

  class ActionsBuilder
    def initialize(actions)
      @actions = actions
    end

    def button(text, type: :button, variant: :primary, **opts)
      @actions.button(text, type:, variant:, **opts)
    end

    def cancel(text = "Cancel", **opts)
      @actions.cancel(text, **opts)
    end

    def submit(text = "Save", **opts)
      @actions.submit(text, **opts)
    end
  end
end
