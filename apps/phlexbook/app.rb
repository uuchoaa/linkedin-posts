# frozen_string_literal: true

require "sinatra/base"
require "active_support/core_ext/object/blank"
require "cuy"
require_relative "phlexbook"
require_relative "views/layout"
require_relative "views/button_page"

module Phlexbook
  class App < Sinatra::Base
    get "/" do
      Phlexbook::ButtonPage.new.call
    end
  end
end
