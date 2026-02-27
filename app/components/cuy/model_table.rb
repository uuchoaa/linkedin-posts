# frozen_string_literal: true

class Cuy::ModelTable < Cuy::Base
  DEFAULT_EXCLUDED = %w[id created_at updated_at].freeze

  def initialize(collection, presenter: nil)
    @collection = collection
    @model_class = collection.first&.class || collection.model
    @presenter = presenter
  end

  def view_template
    render Cuy::Table.new(@collection) do |t|
      columns.each do |col|
        t.column(label(col), primary: col == primary_column) do |record|
          format_value(record, col)
        end
      end

      t.column("Actions", align: :right) do |record|
        actions(record)
      end
    end
  end

  private

  def columns
    return @presenter.columns if @presenter&.respond_to?(:columns)

    @model_class.column_names.reject do |col|
      DEFAULT_EXCLUDED.include?(col) || col.end_with?("_id")
    end
  end

  def primary_column
    return @presenter.primary_column if @presenter&.respond_to?(:primary_column)

    "title"
  end

  def label(col)
    @model_class.human_attribute_name(col)
  end

  def format_value(record, col)
    value = record.send(col)
    column_meta = @model_class.columns_hash[col.to_s]

    if @model_class.defined_enums.key?(col.to_s)
      variant = @presenter&.respond_to?(:badge_variant) ? @presenter.badge_variant(col, value) : :neutral
      render Cuy::Badge.new(variant:) { value&.humanize }
    elsif column_meta&.type == :datetime || column_meta&.type == :date
      value&.strftime("%Y-%m-%d")
    elsif column_meta&.type == :boolean
      render Cuy::Badge.new(variant: value ? :success : :neutral) { value ? "Yes" : "No" }
    elsif value.is_a?(Array)
      value.join(", ")
    else
      value
    end
  end

  def actions(record)
    return @presenter.actions(self, record) if @presenter&.respond_to?(:actions)

    render Cuy::Button.new(variant: :ghost, href: helpers.polymorphic_path(record)) { "Show" }
    render Cuy::Button.new(variant: :ghost, href: helpers.polymorphic_path([ :edit, record ])) { "Edit" }
    render Cuy::Button.new(variant: :danger, href: helpers.polymorphic_path(record), method: :delete, confirm: "Are you sure?") { "Delete" }
  end
end
