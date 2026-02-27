# frozen_string_literal: true

class Views::Base < Cuy::Base
  def around_template
    render Cuy::Layout.new { super }
  end
end
