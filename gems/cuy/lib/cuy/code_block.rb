# frozen_string_literal: true

class Cuy::CodeBlock < Cuy::Base
  cuy_helper :cuy_code_block

  def initialize(code, collapsible: true)
    @code = code
    @collapsible = collapsible
  end

  def view_template
    if @collapsible
      details class: "mt-4" do
        summary class: "text-xs text-gray-500 cursor-pointer hover:text-gray-700" do
          plain "View code"
        end
        render_code
      end
    else
      render_code
    end
  end

  private

  def render_code
    pre class: "mt-2 p-4 rounded bg-[#1e1e1e] text-gray-300 text-xs overflow-x-auto" do
      code { plain @code }
    end
  end
end
