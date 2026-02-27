class Views::Posts::IndexView < Cuy::PageView
  def initialize(posts:, params:)
    @posts = posts
    @params = params
  end

  def navbar
    render Cuy::Navbar.new
  end

  def page_header
    render Cuy::PageHeader.new(title: "Posts")
      .with_action(Cuy::Button.new(href: new_post_path) { "New Post" })
  end

  def main_content
    render Cuy::ModelFilterBar.new(model: Post, url: posts_path, params: @params)
    render Cuy::ModelTable.new(@posts, presenter: Posts::TablePresenter.new)
  end
end
