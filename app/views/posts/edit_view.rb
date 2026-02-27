class Views::Posts::EditView < Views::Base
  def initialize(post:)
    @post = post
  end

  def view_template
    div(class: "w-full max-w-3xl") do
      render Components::PageHeader.new(title: "Edit Post")
      render Components::PostForm.new(post: @post)
    end
  end
end
