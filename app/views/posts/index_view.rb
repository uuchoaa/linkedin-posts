class Views::Posts::IndexView < Views::Base
  def initialize(posts:, params:)
    @posts = posts
    @params = params
  end

  def template
    div(class: "w-full") do
      render Components::PageHeader.new(title: "Posts") do
        unsafe_raw link_to("New Post", new_post_path, class: "rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700")
      end

      filters
      table
    end
  end

  private

  def filters
    form_with url: posts_path, method: :get, class: "mb-6 flex gap-4 items-end" do |form|
      div do
        unsafe_raw form.label(:status, "Status", class: "block text-sm font-medium text-gray-700 mb-1")
        unsafe_raw form.select(
          :status,
          helpers.options_for_select([["All", ""]] + options_from_enum(Post.statuses), @params[:status]),
          {},
          class: "rounded border border-gray-300 px-3 py-2"
        )
      end

      div do
        unsafe_raw form.label(:category, "Category", class: "block text-sm font-medium text-gray-700 mb-1")
        unsafe_raw form.select(
          :category,
          helpers.options_for_select([["All", ""]] + options_from_enum(Post.categories), @params[:category]),
          {},
          class: "rounded border border-gray-300 px-3 py-2"
        )
      end

      unsafe_raw form.submit("Filter", class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300")
    end
  end

  def table
    div(class: "overflow-x-auto rounded-lg border border-gray-200") do
      table(class: "min-w-full divide-y divide-gray-200") do
        thead(class: "bg-gray-50") do
          tr do
            %w[Title Category Status Skill\ Level Created Actions].each do |header|
              th(class: "px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase") { header }
            end
          end
        end

        tbody(class: "bg-white divide-y divide-gray-200") do
          @posts.each do |post|
            tr do
              td(class: "px-6 py-4 text-sm text-gray-900") { post.title }
              td(class: "px-6 py-4 text-sm text-gray-600") { post.category.humanize }
              td(class: "px-6 py-4 text-sm text-gray-600") { post.status.humanize }
              td(class: "px-6 py-4 text-sm text-gray-600") { post.skill_level }
              td(class: "px-6 py-4 text-sm text-gray-600") { post.created_at.strftime("%Y-%m-%d") }
              td(class: "px-6 py-4 text-sm text-right space-x-2") do
                unsafe_raw link_to("Show", post, class: "text-blue-600 hover:underline")
                unsafe_raw link_to("Write", write_post_path(post), class: "text-blue-600 hover:underline")
                unsafe_raw link_to("Edit", edit_post_path(post), class: "text-blue-600 hover:underline")
                unsafe_raw button_to("Delete", post, method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "text-red-600 hover:underline inline")
              end
            end
          end
        end
      end
    end
  end

  def options_from_enum(enum_hash)
    enum_hash.keys.map { |key| [key.humanize, key] }
  end
end
