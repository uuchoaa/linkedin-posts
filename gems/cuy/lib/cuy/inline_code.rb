# frozen_string_literal: true

class Cuy::InlineCode < Cuy::Base
  cuy_helper :cuy_inline_code

  def view_template(&block)
    code class: "px-1.5 py-0.5 rounded bg-gray-100 font-mono text-xs" do
      yield if block_given?
    end
  end
end
