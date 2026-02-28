# frozen_string_literal: true

class Cuy::Base < Phlex::HTML
  class << self
    def cuy_helper(primary)
      @cuy_helper_name = primary
    end

    def cuy_helper_names
      Array(@cuy_helper_name)
    end
  end
end
