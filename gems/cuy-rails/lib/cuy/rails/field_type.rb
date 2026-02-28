# frozen_string_literal: true

class Cuy::Rails::FieldType
  def self.resolve(model_class, attr)
    type_name  = detect(model_class, attr)
    model_ns   = model_class.name.pluralize
    attr_const = attr.to_s.camelize
    type_const = type_name.to_s.camelize

    [
      "Views::#{model_ns}::FieldTypes::#{attr_const}",
      "Views::#{model_ns}::FieldTypes::#{type_const}",
      "Cuy::Rails::FieldTypes::#{type_const}",
      "Cuy::FieldTypes::#{type_const}",
      "Cuy::FieldTypes::Default"
    ].each { |k| return k.constantize if Object.const_defined?(k) }
  end

  def self.detect(model_class, attr)
    col = model_class.columns_hash[attr.to_s]
    return :belongs_to if model_class.reflect_on_all_associations(:belongs_to)
                                     .any? { |a| "#{a.name}_id" == attr.to_s }
    return :enum       if model_class.defined_enums.key?(attr.to_s)
    return :boolean   if col&.type == :boolean
    return :datetime  if col&.type == :datetime || col&.type == :date
    return :text      if col&.type == :text
    return :array     if col&.sql_type&.include?("[]")
    :string
  end
end
