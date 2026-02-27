class Views::Posts::IndexView < Views::Base
  def initialize(posts:, params:)
    @posts = posts
    @params = params
  end

  def around_template
    yield
  end

  def view_template
    render Cuy::Page.new do |page|
      page.with_navbar { render Cuy::Navbar.new }

      page.with_header do
        render Cuy::PageHeader.new(title: "Posts") do
          render Cuy::Button.new(href: new_post_path) { "New Post" }
        end
      end

      page.with_main do
        render Cuy::ModelFilterBar.new(model: Post, url: posts_path, params: @params)
        render Cuy::ModelTable.new(@posts, presenter: Posts::TablePresenter.new)
      end
    end
  end
end
