# frozen_string_literal: true

class Views::Base < Components::Base
  def around_template
    render Components::ApplicationLayout.new { super }
  end
end
