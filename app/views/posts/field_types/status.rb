# frozen_string_literal: true

class Views::Posts::FieldTypes::Status
  def self.render_table(renderer, record, _attr)
    renderer.render Cuy::Badge.new(variant: Cuy::Badge.variant_for_status(record.status)) {
      record.status&.humanize
    }
  end

  def self.render_show(renderer, record, _attr)
    renderer.render Cuy::Badge.new(variant: Cuy::Badge.variant_for_status(record.status)) {
      record.status&.humanize
    }
  end
end
