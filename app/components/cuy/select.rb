# frozen_string_literal: true

class Cuy::Select < Cuy::Base
  def initialize(name:, options:, label: nil, selected: nil, include_blank: false)
    @name = name
    @options = options
    @label = label
    @selected = selected
    @include_blank = include_blank
  end

  def view_template
    div do
      if @label
        label(for: @name, class: "block text-sm font-medium text-gray-700 mb-1") { @label }
      end
      select(name: @name, id: @name, class: "rounded border border-gray-300 px-3 py-2") do
        option(value: "") { "All" } if @include_blank
        @options.each do |(label, value)|
          if @selected.to_s == value.to_s
            option(value: value, selected: true) { label }
          else
            option(value: value) { label }
          end
        end
      end
    end
  end
end
