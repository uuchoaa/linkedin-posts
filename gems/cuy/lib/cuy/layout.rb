# frozen_string_literal: true

class Cuy::Layout < Cuy::Base
  def initialize(title: "App")
    @title = title
  end

  def view_template(&block)
    doctype
    html do
      head do
        title { @title }
        meta name: "viewport", content: "width=device-width,initial-scale=1"
      end

      body do
        yield
      end
    end
  end
end
