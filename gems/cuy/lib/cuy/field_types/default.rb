# frozen_string_literal: true

class Cuy::FieldTypes::Default
  def self.render_table(renderer, record, attr)
    renderer.plain record.send(attr).to_s
  end

  def self.render_show(renderer, record, attr)
    renderer.plain record.send(attr).to_s
  end
end
