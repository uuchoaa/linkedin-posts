class Components::PostForm < Components::Base
  INPUT_CLASS = "w-full rounded border border-gray-300 px-3 py-2"
  LABEL_CLASS = "block text-sm font-medium text-gray-700 mb-1"

  def initialize(post:)
    @post = post
  end

  def view_template
    form_with model: @post, class: "space-y-12" do |form|
      render Components::Rendering::ErrorSummary.new(resource: @post)

      cuy_section(title: "Post", description: "Basic post information") do
        cuy_grid(cols: { base: 1, sm: 6 }, gap: { x: 6, y: 8 }) do |grid|
          grid.column(span: :full) do
            form.label(:external_id, class: LABEL_CLASS)
            form.number_field(:external_id, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:title, class: LABEL_CLASS)
            form.text_field(:title, class: INPUT_CLASS)
          end

          grid.column(span: 3) do
            form.label(:category, class: LABEL_CLASS)
            form.select(
              :category,
              Post.categories.keys.map { |k| [ k.humanize, k ] },
              { include_blank: true, selected: @post.category },
              class: INPUT_CLASS
            )
          end

          grid.column(span: 3) do
            form.label(:status, class: LABEL_CLASS)
            form.select(
              :status,
              Post.statuses.keys.map { |k| [ k.humanize, k ] },
              { selected: @post.status },
              class: INPUT_CLASS
            )
          end

          grid.column(span: 4) do
            form.label(:skill_level, class: LABEL_CLASS)
            form.text_field(:skill_level, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:hook, class: LABEL_CLASS)
            form.text_area(:hook, rows: 3, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:content_summary, class: LABEL_CLASS)
            form.text_area(:content_summary, rows: 5, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:senior_insight, class: LABEL_CLASS)
            form.text_area(:senior_insight, rows: 3, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:cta, class: LABEL_CLASS)
            form.text_area(:cta, rows: 2, class: INPUT_CLASS)
          end

          grid.column(span: :full) do
            form.label(:hashtags, class: LABEL_CLASS)
            form.text_field(
              :hashtags,
              value: @post.hashtags&.join(" "),
              placeholder: "#tag1 #tag2",
              class: INPUT_CLASS
            )
          end
        end
      end

      cuy_actions(align: :end, gap: 6) do |actions|
        actions.submit(@post.new_record? ? "Create Post" : "Update Post")
      end
    end
  end
end
