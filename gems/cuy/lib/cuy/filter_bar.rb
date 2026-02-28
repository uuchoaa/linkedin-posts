# frozen_string_literal: true

class Cuy::FilterBar < Cuy::Base
  def initialize(url:)
    @url = url
  end

  def view_template(&block)
    form(action: @url, method: :get, class: "mb-6 flex gap-4 items-end") do
      block&.call
      input(type: "submit", value: "Filter", class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300 cursor-pointer")
    end
  end
end
