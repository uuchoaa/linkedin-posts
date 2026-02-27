# frozen_string_literal: true

class Views::Posts::Base < Cuy::PageView
  def navbar = render Cuy::Navbar.new
end
