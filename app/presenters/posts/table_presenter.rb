# frozen_string_literal: true

class Posts::TablePresenter
  def columns
    %w[title category status skill_level created_at]
  end

  def primary_column
    "title"
  end

  def badge_variant(col, value)
    return Cuy::Badge.variant_for_status(value) if col == "status"

    :neutral
  end

  def actions(renderer, post)
    renderer.cuy_button(variant: :ghost, href: renderer.post_path(post)) { "Show" }
    renderer.cuy_button(variant: :ghost, href: renderer.write_post_path(post)) { "Write" }
    renderer.cuy_button(variant: :ghost, href: renderer.edit_post_path(post)) { "Edit" }
    renderer.cuy_button(variant: :danger, href: renderer.post_path(post), method: :delete, confirm: "Are you sure?") { "Delete" }
  end
end
