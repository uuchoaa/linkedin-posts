# frozen_string_literal: true

class Cuy::Table < Cuy::Base
  TD_CLASSES = {
    left:  "px-6 py-4 text-sm text-gray-600",
    right: "px-6 py-4 text-sm text-right space-x-2"
  }.freeze

  TD_PRIMARY_CLASSES = "px-6 py-4 text-sm text-gray-900"

  def initialize(rows)
    @rows = rows
    @columns = []
  end

  def view_template(&block)
    block&.call(self)

    div(class: "overflow-x-auto rounded-lg border border-gray-200") do
      table(class: "min-w-full divide-y divide-gray-200") do
        thead(class: "bg-gray-50") do
          tr do
            @columns.each do |col|
              th(class: "px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase") { col[:header] }
            end
          end
        end

        tbody(class: "bg-white divide-y divide-gray-200") do
          @rows.each do |row|
            tr do
              @columns.each do |col|
                classes = col[:primary] ? TD_PRIMARY_CLASSES : TD_CLASSES[col[:align]]
                td(class: classes) { col[:content].call(row) }
              end
            end
          end
        end
      end
    end
  end

  def column(header, primary: false, align: :left, &content)
    @columns << { header:, primary:, align:, content: }
    nil
  end
end
