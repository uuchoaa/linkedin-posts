# frozen_string_literal: true

require "phlex"

module Cuy
  extend Phlex::Kit
  module FieldTypes
  end

  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end
  end
end

require "cuy/config_object"
require "cuy/components_config"
require "cuy/config"
require "cuy/base"
require "cuy/badge"
require "cuy/button"
require "cuy/select"
require "cuy/table"
require "cuy/form"
require "cuy/form/grid"
require "cuy/form/section"
require "cuy/form/actions"
require "cuy/filter_bar"
require "cuy/page_header"
require "cuy/sidebar"
require "cuy/breadcrumb"
require "cuy/top_bar"
require "cuy/main"
require "cuy/card"
require "cuy/code_block"
require "cuy/section"
require "cuy/prose"
require "cuy/inline_code"
require "cuy/flex"
require "cuy/container"
require "cuy/grid"
require "cuy/layout"
require "cuy/navbar"
require "cuy/page_view"

require "cuy/field_types/string"
require "cuy/field_types/boolean"
require "cuy/field_types/text"
require "cuy/field_types/datetime"
require "cuy/field_types/array"
require "cuy/field_types/enum"
require "cuy/field_types/belongs_to"
require "cuy/field_types/default"
