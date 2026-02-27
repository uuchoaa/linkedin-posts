# frozen_string_literal: true

class Cuy::Table < Cuy::Base
  def initialize(rows)
    @rows = rows
    @columns = []
  end

  def view_template(&)
    vanish(&)

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
                td(class: col[:classes]) { col[:content].call(row) }
              end
            end
          end
        end
      end
    end
  end

  def column(header, classes: "px-6 py-4 text-sm text-gray-600", &content)
    @columns << { header:, classes:, content: }
    nil
  end
end
