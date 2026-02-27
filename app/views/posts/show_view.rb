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
    dl(class: "space-y-4") do
      detail("Category", @post.category&.humanize) if @post.category
      detail("Status", @post.status&.humanize) if @post.status
      detail("Skill Level", @post.skill_level) if @post.skill_level.present?
      detail("Hook", @post.hook) if @post.hook.present?
      detail("Content Summary", @post.content_summary, multiline: true) if @post.content_summary.present?
      detail("Senior Insight", @post.senior_insight) if @post.senior_insight.present?
      detail("CTA", @post.cta) if @post.cta.present?
      detail("Hashtags", @post.hashtags.join(" ")) if @post.hashtags.any?

      if @post.body.present?
        div do
          dt(class: "text-sm font-medium text-gray-500") { "Body" }
          dd(class: "mt-1 text-gray-900 whitespace-pre-wrap") { @post.body }
        end
      end
    end
  end

  private

  def detail(label, value, multiline: false)
    div do
      dt(class: "text-sm font-medium text-gray-500") { label }
      dd(class: ["mt-1 text-gray-900", ("whitespace-pre-wrap" if multiline)].compact.join(" ")) { value }
    end
  end
end
