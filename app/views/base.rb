# frozen_string_literal: true

class Views::Base < Cuy::Base
  def around_template
    render Cuy::Rails::Layout.new(title: "LinkedIn Posts") { super }
  end
end
