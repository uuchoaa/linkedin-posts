# frozen_string_literal: true

class Cuy::Card < Cuy::Base
  def initialize(padding: :normal, title: nil)
    @padding = padding
    @title = title
  end

  def view_template(&block)
    div class: "rounded-lg border border-gray-200 bg-white shadow-sm #{padding_class}" do
      h2 class: "text-xs font-semibold uppercase tracking-wider text-gray-500 mb-3" do
        plain @title
      end if @title
      yield if block_given?
    end
  end

  private

  def padding_class
    case @padding
    when :large then "p-8"
    else "p-6"
    end
  end
end
