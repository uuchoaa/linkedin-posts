# frozen_string_literal: true

class Views::Posts::ShowView < Views::Posts::Base
  def initialize(post:)
    @post = post
  end

  def page_header
    render Cuy::PageHeader.new(title: @post.title)
      .with_action(Cuy::Button.new(variant: :primary, href: write_post_path(@post)) { "Write Post" })
      .with_action(Cuy::Button.new(variant: :secondary, href: edit_post_path(@post)) { "Edit" })
      .with_action(Cuy::Button.new(variant: :secondary, href: posts_path) { "Back" })
  end

  def main_content
    render Cuy::Rails::ModelShow.new(@post)
  end
end
