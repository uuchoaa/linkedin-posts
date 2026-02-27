class Components::PostForm < Components::Base
  def initialize(post:)
    @post = post
  end

  def view_template
    form_with model: @post, class: "space-y-4" do |form|
      render Components::ErrorSummary.new(resource: @post)

      div do
        form.label(:title, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_field(:title, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div(class: "grid grid-cols-2 gap-4") do
        div do
          form.label(:category, class: "block text-sm font-medium text-gray-700 mb-1")
          form.select(
            :category,
            Post.categories.keys.map { |k| [k.humanize, k] },
            { include_blank: true, selected: @post.category },
            class: "w-full rounded border border-gray-300 px-3 py-2"
          )
        end

        div do
          form.label(:status, class: "block text-sm font-medium text-gray-700 mb-1")
          form.select(
            :status,
            Post.statuses.keys.map { |k| [k.humanize, k] },
            { selected: @post.status },
            class: "w-full rounded border border-gray-300 px-3 py-2"
          )
        end
      end

      div do
        form.label(:skill_level, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_field(:skill_level, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div do
        form.label(:hook, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_area(:hook, rows: 3, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div do
        form.label(:content_summary, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_area(:content_summary, rows: 5, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div do
        form.label(:senior_insight, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_area(:senior_insight, rows: 3, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div do
        form.label(:cta, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_area(:cta, rows: 2, class: "w-full rounded border border-gray-300 px-3 py-2")
      end

      div do
        form.label(:hashtags, class: "block text-sm font-medium text-gray-700 mb-1")
        form.text_field(
          :hashtags,
          value: @post.hashtags&.join(" "),
          placeholder: "#tag1 #tag2",
          class: "w-full rounded border border-gray-300 px-3 py-2"
        )
      end

      div(class: "pt-4") do
        form.submit(nil, class: "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700")
      end
    end
  end
end
