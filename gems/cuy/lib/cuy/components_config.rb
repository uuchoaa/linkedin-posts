# frozen_string_literal: true

module Cuy
  class ComponentsConfig
    def initialize
      @by_component = {}
    end

    def method_missing(name, *args)
      return super unless args.empty?
      @by_component[name.to_sym] ||= {}
    end

    def respond_to_missing?(name, include_private = false)
      true
    end
  end
end
