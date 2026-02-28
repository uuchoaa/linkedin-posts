# frozen_string_literal: true

class Cuy::FieldTypes::String
  def self.render_table(renderer, record, attr)
    renderer.plain record.send(attr)
  end

  def self.render_show(renderer, record, attr)
    renderer.plain record.send(attr)
  end
end
