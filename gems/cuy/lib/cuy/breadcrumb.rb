# frozen_string_literal: true

class Cuy::Breadcrumb < Cuy::Base
  def initialize(segments: [])
    @segments = segments
  end

  def view_template
    return if @segments.empty?

    nav class: "flex items-center gap-2 text-sm text-gray-500" do
      @segments.each_with_index do |segment, i|
        span(class: (i == @segments.length - 1 ? "text-gray-900 font-medium" : nil)) do
          plain segment
        end
        span { plain "/" } if i < @segments.length - 1
      end
    end
  end
end
