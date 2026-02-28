# frozen_string_literal: true

module Cuy
  class Config
    def initialize
      @theme = ConfigObject.new
      @layout = ConfigObject.new
      @components = ComponentsConfig.new
    end

    attr_reader :theme, :layout, :components
  end
end
