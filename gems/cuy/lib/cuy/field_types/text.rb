# frozen_string_literal: true

class Cuy::FieldTypes::Text
  TRUNCATE_LENGTH = 80

  def self.render_table(renderer, record, attr)
    value = record.send(attr).to_s
    truncated = value.length > TRUNCATE_LENGTH ? "#{value[0, TRUNCATE_LENGTH]}..." : value
    renderer.plain truncated
  end

  def self.render_show(renderer, record, attr)
    renderer.whitespace
    renderer.span(class: "whitespace-pre-wrap") { record.send(attr).to_s }
  end
end
