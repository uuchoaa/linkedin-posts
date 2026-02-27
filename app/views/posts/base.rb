# frozen_string_literal: true

class Views::Posts::Base < Cuy::PageView
  def navbar
    render Cuy::Navbar.new do |nav|
      nav.item("Posts", href: posts_path, active: true)
    end
  end
end
