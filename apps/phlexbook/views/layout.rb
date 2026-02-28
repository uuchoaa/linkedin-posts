# frozen_string_literal: true

class Phlexbook::Layout < Cuy::Layout
  def extra_head
    script src: "https://cdn.tailwindcss.com"
    style { plain "html { font-family: 'Nunito Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif; }" }
  end
end
