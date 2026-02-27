# frozen_string_literal: true

class Cuy::ModelFilterBar < Cuy::Base
  def initialize(model:, url:, params: {})
    @model = model
    @url = url
    @params = params
  end

  def view_template
    model  = @model
    params = @params
    url    = @url

    render Cuy::FilterBar.new(url:) do
      model.defined_enums.keys.map(&:to_sym).each do |attribute|
        render Cuy::EnumSelect.new(model:, attribute:, selected: params[attribute])
      end
    end
  end

end
