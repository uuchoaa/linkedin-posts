# frozen_string_literal: true

class Cuy::Flex < Cuy::Base
  cuy_helper :cuy_flex

  def initialize(wrap: false, gap: 4)
    @wrap = wrap
    @gap = gap
  end

  def view_template(&block)
    div class: "flex flex-#{@wrap ? 'wrap' : 'nowrap'} gap-#{@gap}" do
      yield if block_given?
    end
  end
end
