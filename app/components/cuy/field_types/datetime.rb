# frozen_string_literal: true

class Cuy::FieldTypes::Datetime
  def self.render_table(renderer, record, attr)
    renderer.plain record.send(attr)&.strftime("%Y-%m-%d")
  end

  def self.render_show(renderer, record, attr)
    renderer.plain record.send(attr)&.strftime("%b %d, %Y")
  end
end
