class Views::Posts::IndexView < Views::Base
  def initialize(posts:, params:)
    @posts = posts
    @params = params
  end

  def view_template
    render Cuy::PageHeader.new(title: "Posts") do
      render Cuy::Button.new(href: new_post_path) { "New Post" }
    end

    render Cuy::FilterBar.new(url: posts_path) do
      render Cuy::Select.new(
        name: :status,
        label: "Status",
        options: [["All", ""]] + enum_options(Post.statuses),
        selected: @params[:status]
      )
      render Cuy::Select.new(
        name: :category,
        label: "Category",
        options: [["All", ""]] + enum_options(Post.categories),
        selected: @params[:category]
      )
    end

    render Cuy::Table.new(@posts) do |t|
      t.column("Title", primary: true, &:title)
      t.column("Category") { |p| p.category&.humanize }
      t.column("Status") { |p| render Cuy::Badge.new(variant: Cuy::Badge.variant_for_status(p.status)) { p.status&.humanize } }
      t.column("Skill Level", &:skill_level)
      t.column("Created") { |p| p.created_at.strftime("%Y-%m-%d") }
      t.column("Actions", align: :right) do |p|
        render Cuy::Button.new(variant: :ghost, href: post_path(p)) { "Show" }
        render Cuy::Button.new(variant: :ghost, href: write_post_path(p)) { "Write" }
        render Cuy::Button.new(variant: :ghost, href: edit_post_path(p)) { "Edit" }
        render Cuy::Button.new(variant: :danger, href: post_path(p), method: :delete, confirm: "Are you sure?") { "Delete" }
      end
    end
  end

  private

  def enum_options(enum_hash)
    enum_hash.keys.map { |key| [key.humanize, key] }
  end
end
