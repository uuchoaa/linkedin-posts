# frozen_string_literal: true

class Cuy::FilterBar < Cuy::Base
  def initialize(url:)
    @url = url
  end

  def view_template(&filters)
    form_with url: @url, method: :get, class: "mb-6 flex gap-4 items-end" do |form|
      filters&.call
      form.submit("Filter", class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300")
    end
  end
end
