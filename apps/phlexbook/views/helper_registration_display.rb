# frozen_string_literal: true

class Phlexbook::HelperRegistrationDisplay < Cuy::Base
  def initialize(component_class)
    @component_class = component_class
  end

  def view_template
    return unless @component_class.respond_to?(:cuy_helper_names)

    names = @component_class.cuy_helper_names
    return if names.empty?

    p do
      plain (names.size > 1 ? "Helpers " : "Helper ")
      names.each_with_index do |name, i|
        cuy_inline_code { plain name.to_s }
        plain ", " if i < names.size - 1
      end
      plain " — registered in "
      cuy_inline_code { plain @component_class.name }
    end
  end
end
