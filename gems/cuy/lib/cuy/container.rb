# frozen_string_literal: true

class Cuy::Container < Cuy::Base
  cuy_helper :cuy_container

  def initialize(max_width: "4xl", spacing: 12, context: nil)
    @max_width = max_width
    @spacing = spacing
    @context = context
  end

  def view_template(&block)
    div class: "max-w-#{@max_width} space-y-#{@spacing}" do
      if block_given?
        block.arity == 1 ? yield(@context || self) : yield
      end
    end
  end
end
