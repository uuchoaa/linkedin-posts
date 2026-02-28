# frozen_string_literal: true

module Views
end

module Components
  extend Phlex::Kit

  module Rendering
  end
end

module Views::Posts
  module FieldTypes; end
end

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views"), namespace: Views
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components"), namespace: Components
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/rendering"), namespace: Components::Rendering
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/posts/field_types"), namespace: Views::Posts::FieldTypes
)
