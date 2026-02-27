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
    renderer.render Cuy::Button.new(variant: :ghost, href: renderer.post_path(post)) { "Show" }
    renderer.render Cuy::Button.new(variant: :ghost, href: renderer.write_post_path(post)) { "Write" }
    renderer.render Cuy::Button.new(variant: :ghost, href: renderer.edit_post_path(post)) { "Edit" }
    renderer.render Cuy::Button.new(variant: :danger, href: renderer.post_path(post), method: :delete, confirm: "Are you sure?") { "Delete" }
  end
end
