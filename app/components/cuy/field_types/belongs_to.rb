# frozen_string_literal: true

class Cuy::FieldTypes::BelongsTo
  def self.render_table(renderer, record, attr)
    assoc_name = attr.to_s.delete_suffix("_id")
    related = record.send(assoc_name)
    renderer.plain related.to_s
  end

  def self.render_show(renderer, record, attr)
    assoc_name = attr.to_s.delete_suffix("_id")
    related = record.send(assoc_name)
    return if related.nil?

    renderer.a(href: renderer.helpers.polymorphic_path(related),
               class: "text-blue-600 hover:underline") { related.to_s }
  end
end
