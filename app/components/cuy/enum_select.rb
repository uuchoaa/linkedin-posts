# frozen_string_literal: true

class Cuy::EnumSelect < Cuy::Base
  def initialize(model:, attribute:, selected: nil)
    @model = model
    @attribute = attribute
    @selected = selected
  end

  def view_template
    render Cuy::Select.new(
      name: @attribute,
      label: @model.human_attribute_name(@attribute),
      options: [ [ "All", "" ] ] + enum_options,
      selected: @selected
    )
  end

  private

  def enum_options
    @model.send(@attribute.to_s.pluralize).keys.map { |k| [ k.humanize, k ] }
  end
end
