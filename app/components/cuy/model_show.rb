# frozen_string_literal: true

class Cuy::ModelShow < Cuy::Base
  DEFAULT_EXCLUDED = %w[id created_at updated_at].freeze

  def initialize(record, presenter: nil)
    @record = record
    @model_class = record.class
    @presenter = presenter
  end

  def view_template
    dl(class: "space-y-4") do
      columns.each do |col|
        field_type = Cuy::FieldType.resolve(@model_class, col)
        div do
          dt(class: "text-sm font-medium text-gray-500") { @model_class.human_attribute_name(col) }
          dd(class: "mt-1 text-gray-900") { field_type.render_show(self, @record, col) }
        end
      end
    end
  end

  private

  def columns
    return @presenter.columns if @presenter&.respond_to?(:columns)

    @model_class.column_names.reject { |col| DEFAULT_EXCLUDED.include?(col) }
  end
end
