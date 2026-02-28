# frozen_string_literal: true

class Cuy::Form < Cuy::Base
  def initialize(action:, method: :post, **html_options)
    @action = action
    @method = method
    @html_options = html_options
  end

  def view_template(&block)
    form(
      action: @action,
      method: @method == :get ? :get : :post,
      class: "space-y-12",
      **@html_options
    ) do
      input(type: "hidden", name: "_method", value: @method.to_s.upcase) if @method != :get && @method != :post
      yield
    end
  end
end
