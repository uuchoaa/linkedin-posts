# frozen_string_literal: true

class Cuy::Grid < Cuy::Base
  PRESETS = {
    # cols: 1 on mobile, 2 from sm
    two:      { cols: { base: 1, sm: 2 }, gap: 4 },
    # 1 → 3
    three:    { cols: { base: 1, sm: 2, md: 3 }, gap: 4 },
    # 1 → 4
    four:     { cols: { base: 1, sm: 2, md: 4 }, gap: 4 },
    # 1 → 6 (form-style)
    six:      { cols: { base: 1, sm: 6 }, gap: { x: 6, y: 8 } },
    # 2 cols fixed
    two_fixed: { cols: 2, gap: 4 },
    # 3 cols fixed
    three_fixed: { cols: 3, gap: 4 },
    # auto-fit minmax for equal columns
    auto:     { cols: :auto, gap: 4 },
    # single column (stack)
    stack:    { cols: 1, gap: 4 }
  }.freeze

  def initialize(preset: nil, cols: nil, gap: nil, **html_options)
    if preset && PRESETS.key?(preset.to_sym)
      config = PRESETS[preset.to_sym]
      @cols = config[:cols]
      @gap = config[:gap]
    else
      @cols = cols || { base: 1, sm: 2 }
      @gap = gap || 4
    end
    @html_options = html_options
  end

  def view_template(&block)
    div(class: [ "grid", cols_class, gap_class ].join(" "), **@html_options, &block)
  end

  private

  def cols_class
    case @cols
    when :auto
      "grid-cols-[repeat(auto-fit,minmax(0,1fr))]"
    when Hash
      @cols.map { |k, v| k == :base ? "grid-cols-#{v}" : "#{k}:grid-cols-#{v}" }.join(" ")
    when Integer
      "grid-cols-#{@cols}"
    else
      "grid-cols-1 sm:grid-cols-2"
    end
  end

  def gap_class
    case @gap
    when Hash
      x = @gap[:x] || @gap
      y = @gap[:y] || @gap
      "gap-x-#{x} gap-y-#{y}"
    when Integer
      "gap-#{@gap}"
    else
      "gap-4"
    end
  end
end
