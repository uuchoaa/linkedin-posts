# frozen_string_literal: true

class Cuy::Form::Section < Cuy::Base
  SPACING = {
    tight:  "space-y-6",
    normal: "space-y-12",
    loose:  "space-y-16"
  }.freeze

  def initialize(title:, description: nil, border: true, spacing: :normal, **html_options)
    @title = title
    @description = description
    @border = border
    @spacing = spacing
    @html_options = html_options
  end

  def view_template(&block)
    div(
      class: [
        "pb-12",
        ("border-b border-gray-900/10 dark:border-white/10" if @border),
        SPACING[@spacing]
      ].compact.join(" "),
      **@html_options
    ) do
      h2(class: "text-base/7 font-semibold text-gray-900 dark:text-white") { @title }
      p(class: "mt-1 text-sm/6 text-gray-600 dark:text-gray-400") { @description } if @description
      div(class: "mt-10", &block)
    end
  end
end
