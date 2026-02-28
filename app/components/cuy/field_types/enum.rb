# frozen_string_literal: true

class Cuy::FieldTypes::Enum
  def self.render_table(renderer, record, attr)
    renderer.render Cuy::Badge.new(variant: :neutral) { record.send(attr)&.humanize }
  end

  def self.render_show(renderer, record, attr)
    renderer.render Cuy::Badge.new(variant: :neutral) { record.send(attr)&.humanize }
  end
end
