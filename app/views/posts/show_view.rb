class Views::Posts::ShowView < Views::Base
  def initialize(post:)
    @post = post
  end

  def template
    div(class: "w-full max-w-3xl") do
      render Components::PageHeader.new(title: @post.title) do
        unsafe_raw link_to("Write Post", write_post_path(@post), class: "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700")
        unsafe_raw link_to("Edit", edit_post_path(@post), class: "rounded-lg bg-gray-600 px-4 py-2 text-white hover:bg-gray-700")
        unsafe_raw link_to("Back", posts_path, class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300")
      end

      dl(class: "space-y-4") do
        detail("Category", @post.category.humanize)
        detail("Status", @post.status.humanize)
        detail("Skill Level", @post.skill_level)
        detail("Hook", @post.hook)
        detail("Content Summary", @post.content_summary, multiline: true)
        detail("Senior Insight", @post.senior_insight)
        detail("CTA", @post.cta)
        detail("Hashtags", @post.hashtags.join(" ")) if @post.hashtags.any?

        if @post.body.present?
          div do
            dt(class: "text-sm font-medium text-gray-500") { "Body" }
            dd(class: "mt-1 text-gray-900 whitespace-pre-wrap") { @post.body }
          end
        end
      end
    end
  end

  private

  def detail(label, value, multiline: false)
    div do
      dt(class: "text-sm font-medium text-gray-500") { label }
      classes = ["mt-1 text-gray-900"]
      classes << "whitespace-pre-wrap" if multiline
      dd(class: classes.join(" ")) { value }
    end
  end
end
