# frozen_string_literal: true

class Cuy::Rails::Railtie < Rails::Railtie
  config.before_eager_load do
    require "cuy/rails/base"
    require "cuy/rails/layout"
    require "cuy/rails/navbar"
    require "cuy/rails/page_view"
    require "cuy/rails/field_type"
    require "cuy/rails/field_types/belongs_to"
    require "cuy/rails/model_table"
    require "cuy/rails/model_show"
    require "cuy/rails/model_filter_bar"
    require "cuy/rails/enum_select"
    require "cuy/rails/index_view"

    # Aliases for drop-in compatibility (Layout/PageView stay in cuy - app uses Rails:: versions)
    Cuy::IndexView       = Cuy::Rails::IndexView
    Cuy::ModelTable      = Cuy::Rails::ModelTable
    Cuy::ModelShow       = Cuy::Rails::ModelShow
    Cuy::ModelFilterBar  = Cuy::Rails::ModelFilterBar
    Cuy::EnumSelect      = Cuy::Rails::EnumSelect
    Cuy::FieldType       = Cuy::Rails::FieldType

    # App overrides
    Rails.autoloaders.main.push_dir(
      Rails.root.join("app/components/cuy"),
      namespace: Cuy
    ) if Rails.root.join("app/components/cuy").exist?

    Rails.autoloaders.main.push_dir(
      Rails.root.join("app/components/cuy/field_types"),
      namespace: Cuy::FieldTypes
    ) if Rails.root.join("app/components/cuy/field_types").exist?
  end
end
