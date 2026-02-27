# frozen_string_literal: true

class Cuy::Table < Cuy::Base
  def view_template(&block)
    div(class: "overflow-x-auto rounded-lg border border-gray-200") do
      table(class: "min-w-full divide-y divide-gray-200", &block)
    end
  end

  def with_header(&block)
    thead(class: "bg-gray-50") do
      tr(&block)
    end
  end

  def with_body(&block)
    tbody(class: "bg-white divide-y divide-gray-200", &block)
  end

  def col_header(text)
    th(class: "px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase") { text }
  end

  def col_primary(text = nil, &block)
    td(class: "px-6 py-4 text-sm text-gray-900") { block ? yield : text }
  end

  def col(text = nil, &block)
    td(class: "px-6 py-4 text-sm text-gray-600") { block ? yield : text }
  end

  def col_actions(&block)
    td(class: "px-6 py-4 text-sm text-right space-x-2", &block)
  end
end
