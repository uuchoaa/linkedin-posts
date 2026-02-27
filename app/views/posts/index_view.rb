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

    render Cuy::ModelTable.new(@posts, presenter: Posts::TablePresenter.new)
  end

  private

  def enum_options(enum_hash)
    enum_hash.keys.map { |key| [key.humanize, key] }
  end
end
