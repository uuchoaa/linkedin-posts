# frozen_string_literal: true

class Cuy::FieldTypes::Array
  def self.render_table(renderer, record, attr)
    renderer.plain record.send(attr).join(", ")
  end

  def self.render_show(renderer, record, attr)
    renderer.plain record.send(attr).join(", ")
  end
end
