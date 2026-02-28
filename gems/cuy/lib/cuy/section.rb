# frozen_string_literal: true

class Cuy::Section < Cuy::Base
  cuy_helper :cuy_doc_section

  def initialize(id: nil, title: nil, description: nil)
    @id = id
    @title = title
    @description = description
  end

  def view_template(&block)
    section(id: @id) do
      h2 class: "text-xs font-semibold uppercase tracking-wider text-gray-500 mb-2" do
        plain @title
      end if @title
      p class: "text-sm text-gray-500 mb-3" do
        plain @description
      end if @description
      yield if block_given?
    end
  end
end
