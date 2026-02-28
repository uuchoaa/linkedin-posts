# frozen_string_literal: true

class Cuy::TopBar < Cuy::Base
  def initialize(breadcrumb: nil, right: nil, context: nil, &block)
    @breadcrumb = breadcrumb
    @right = right
    @context = context
    @block = block
  end

  def view_template
    header class: "flex-shrink-0 h-12 flex items-center gap-4 px-6 bg-white border-b border-gray-200" do
      if @breadcrumb
        render Cuy::Breadcrumb.new(segments: @breadcrumb)
      elsif @block
        (@context || self).instance_eval(&@block)
      end
      span class: "text-xs text-gray-400 ml-auto" do
        plain @right
      end if @right
    end
  end
end
