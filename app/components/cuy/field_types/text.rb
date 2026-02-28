# frozen_string_literal: true

class Cuy::FieldTypes::Text
  TRUNCATE_LENGTH = 80

  def self.render_table(renderer, record, attr)
    value = record.send(attr).to_s
    renderer.plain value.truncate(TRUNCATE_LENGTH)
  end

  def self.render_show(renderer, record, attr)
    renderer.whitespace
    renderer.span(class: "whitespace-pre-wrap") { record.send(attr) }
  end
end
