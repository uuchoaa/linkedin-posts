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
    renderer.plain related.to_s
  end
end
