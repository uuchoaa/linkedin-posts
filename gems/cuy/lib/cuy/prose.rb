# frozen_string_literal: true

class Cuy::Prose < Cuy::Base
  def initialize(size: :sm)
    @size = size
  end

  def view_template(&block)
    div class: "prose prose-#{@size} max-w-none text-gray-600" do
      yield if block_given?
    end
  end
end
