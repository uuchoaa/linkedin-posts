class Views::Posts::WriteView < Views::Base
  def initialize(post:)
    @post = post
  end

  def template
    div(class: "w-full max-w-3xl") do
      render Components::PageHeader.new(title: "Write Post: #{@post.title}") do
        unsafe_raw link_to("Back", @post, class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300")
      end

      render Components::PostReferenceCard.new(post: @post)

      form_with model: @post,
                url: write_post_path(@post),
                method: :patch,
                class: "space-y-4",
                data: { controller: "generate-body", generate_body_url_value: generate_body_post_path(@post) } do |form|
        render Components::ErrorSummary.new(resource: @post)

        div do
          div(class: "flex justify-between items-center mb-1") do
            unsafe_raw form.label(:body, class: "block text-sm font-medium text-gray-700")
            button(type: "button",
                   class: "inline-flex items-center gap-2 rounded-lg bg-violet-100 px-3 py-1.5 text-sm font-medium text-violet-700 hover:bg-violet-200",
                   data: { action: "click->generate-body#generate", generate_body_target: "button" }) do
              svg(xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke_width: "1.5", stroke: "currentColor", class: "size-4") do
                path(stroke_linecap: "round", stroke_linejoin: "round",
                     d: "M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456z")
              end
              text "Write with AI"
            end
          end

          unsafe_raw form.text_area(
            :body,
            rows: 15,
            class: "w-full rounded border border-gray-300 px-3 py-2 font-mono text-sm",
            placeholder: "Write your LinkedIn post here...",
            data: { generate_body_target: "textarea" }
          )
        end

        div(class: "pt-4") do
          unsafe_raw form.submit("Save body", class: "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700")
        end
      end
    end
  end
end
