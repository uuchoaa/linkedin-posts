# frozen_string_literal: true

class Cuy::Main < Cuy::Base
  def initialize(context: nil, &block)
    @context = context
    @block = block
  end

  def view_template
    main class: "flex-1 overflow-auto p-6" do
      if @block && @context
        # Run block in parent context so render_slot works
        @context.instance_exec(&@block)
      elsif @block
        instance_eval(&@block)
      end
    end
  end
end
