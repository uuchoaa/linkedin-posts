# frozen_string_literal: true

class Views::Posts::IndexView < Cuy::Rails::IndexView
  model_class Post

  def layout_title
    "LinkedIn Posts"
  end
end
