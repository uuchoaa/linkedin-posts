# frozen_string_literal: true

module Cuy
  class ConfigObject
    def initialize
      @data = {}
    end

    def method_missing(name, *args)
      name_str = name.to_s
      if name_str.end_with?("=")
        key = name_str.delete_suffix("=").to_sym
        @data[key] = args.first
      elsif args.empty?
        key = name.to_sym
        @data[key] = ConfigObject.new unless @data.key?(key)
        @data[key]
      else
        super
      end
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, val)
      @data[key.to_sym] = val
    end

    def to_h
      @data.transform_values { |v| v.is_a?(ConfigObject) ? v.to_h : v }
    end

    def respond_to_missing?(name, include_private = false)
      true
    end
  end
end
