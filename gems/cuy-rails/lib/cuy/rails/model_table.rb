# frozen_string_literal: true

class Cuy::Rails::ModelTable < Cuy::Base
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

    @model_class.column_names.reject { |col| DEFAULT_EXCLUDED.include?(col) }
  end

  def primary_column
    return @presenter.primary_column if @presenter&.respond_to?(:primary_column)

    "title"
  end

  def label(col)
    @model_class.human_attribute_name(col)
  end

  def format_value(record, col)
    Cuy::Rails::FieldType.resolve(@model_class, col).render_table(self, record, col)
  end

  def actions(record)
    return @presenter.actions(self, record) if @presenter&.respond_to?(:actions)

    cuy_button(variant: :ghost, href: helpers.polymorphic_path(record)) { "Show" }
    cuy_button(variant: :ghost, href: helpers.polymorphic_path([ :edit, record ])) { "Edit" }
    cuy_button(variant: :danger, href: helpers.polymorphic_path(record), method: :delete, confirm: "Are you sure?") { "Delete" }
  end
end
