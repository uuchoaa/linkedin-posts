# frozen_string_literal: true

class Cuy::FieldTypes::Boolean
  def self.render_table(renderer, record, attr)
    value = record.send(attr)
    renderer.render Cuy::Badge.new(variant: value ? :success : :neutral) { value ? "Yes" : "No" }
  end

  def self.render_show(renderer, record, attr)
    value = record.send(attr)
    renderer.render Cuy::Badge.new(variant: value ? :success : :neutral) { value ? "Yes" : "No" }
  end
end
