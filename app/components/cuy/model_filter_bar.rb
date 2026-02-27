# frozen_string_literal: true

class Cuy::ModelFilterBar < Cuy::Base
  def initialize(model:, url:, params: {})
    @model = model
    @url = url
    @params = params
  end

  def view_template
    render Cuy::FilterBar.new(url: @url) do
      enum_attributes.each do |attribute|
        render Cuy::EnumSelect.new(
          model: @model,
          attribute: attribute,
          selected: @params[attribute]
        )
      end
    end
  end

  private

  def enum_attributes
    @model.defined_enums.keys.map(&:to_sym)
  end
end
