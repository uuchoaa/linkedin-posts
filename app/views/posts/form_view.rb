# frozen_string_literal: true

class Views::Posts::FormView < Views::Posts::Base
  def initialize(post:)
    @post = post
  end

  def page_header
    render Cuy::PageHeader.new(title: form_title)
  end

  def main_content
    render Components::PostForm.new(post: @post)
  end
end
