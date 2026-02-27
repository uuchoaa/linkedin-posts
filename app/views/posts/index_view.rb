class Views::Posts::IndexView < Views::Base
  def initialize(posts:, params:)
    @posts = posts
    @params = params
  end

  def view_template
    div(class: "w-full") do
      render Cuy::PageHeader.new(title: "Posts") do
        render Cuy::Button.new(href: new_post_path) { "New Post" }
      end

      filters
      posts_table
    end
  end

  private

  def filters
    form_with url: posts_path, method: :get, class: "mb-6 flex gap-4 items-end" do |form|
      render Cuy::Select.new(
        name: :status,
        label: "Status",
        options: [["All", ""]] + enum_options(Post.statuses),
        selected: @params[:status],
        include_blank: false
      )

      render Cuy::Select.new(
        name: :category,
        label: "Category",
        options: [["All", ""]] + enum_options(Post.categories),
        selected: @params[:category],
        include_blank: false
      )

      form.submit("Filter", class: "rounded-lg bg-gray-200 px-4 py-2 hover:bg-gray-300")
    end
  end

  def posts_table
    render Cuy::Table.new do |t|
      t.with_header do
        t.col_header "Title"
        t.col_header "Category"
        t.col_header "Status"
        t.col_header "Skill Level"
        t.col_header "Created"
        t.col_header "Actions"
      end

      t.with_body do
        @posts.each do |post|
          tr do
            t.col_primary post.title
            t.col post.category&.humanize
            t.col do
              render Cuy::Badge.new(variant: Cuy::Badge.variant_for_status(post.status)) { post.status&.humanize }
            end
            t.col post.skill_level
            t.col post.created_at.strftime("%Y-%m-%d")
            t.col_actions do
              link_to "Show", post, class: "text-blue-600 hover:underline"
              link_to "Write", write_post_path(post), class: "text-blue-600 hover:underline"
              link_to "Edit", edit_post_path(post), class: "text-blue-600 hover:underline"
              button_to "Delete", post, method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "text-red-600 hover:underline inline"
            end
          end
        end
      end
    end
  end

  def enum_options(enum_hash)
    enum_hash.keys.map { |key| [key.humanize, key] }
  end
end
