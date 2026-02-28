# frozen_string_literal: true

class Cuy::Form::Grid < Cuy::Base
  def initialize(cols: { base: 1, sm: 6 }, gap: { x: 6, y: 8 }, **html_options)
    @cols = cols
    @gap = gap
    @html_options = html_options
  end

  def view_template(&block)
    div(
      class: [ "grid", cols_class, gap_class ].join(" "),
      **@html_options
    ) do
      yield GridBuilder.new(self)
    end
  end

  def column(span:, **opts, &block)
    span_class = span_class_for(span)
    div(class: span_class, **opts, &block)
  end

  class GridBuilder
    def initialize(grid)
      @grid = grid
    end

    def column(span:, **opts, &block)
      @grid.column(span:, **opts, &block)
    end
  end

  private

  def cols_class
    case @cols
    when Hash
      @cols.map { |k, v| k == :base ? "grid-cols-#{v}" : "#{k}:grid-cols-#{v}" }.join(" ")
    when Integer
      "grid-cols-#{@cols}"
    else
      "grid-cols-1 sm:grid-cols-6"
    end
  end

  def gap_class
    case @gap
    when Hash
      x = @gap[:x] || @gap
      y = @gap[:y] || @gap
      "gap-x-#{x} gap-y-#{y}"
    when Integer
      "gap-x-#{@gap} gap-y-#{@gap}"
    else
      "gap-x-6 gap-y-8"
    end
  end

  def span_class_for(span)
    case span
    when :full
      "col-span-full"
    when Hash
      span.map do |k, v|
        cls = v == :full ? "col-span-full" : "col-span-#{v}"
        k == :base ? cls : "#{k}:#{cls}"
      end.join(" ")
    when Integer
      "sm:col-span-#{span}"
    else
      "sm:col-span-#{span}"
    end
  end
end
