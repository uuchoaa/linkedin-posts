# frozen_string_literal: true

class Cuy::PageHeader < Cuy::Base
  def initialize(title:, **)
    @title = title
    @actions = []
  end

  def with_action(component)
    @actions << component
    self
  end

  def view_template
    div(class: "flex justify-between items-center mb-6") do
      h1(class: "text-2xl font-bold") { @title }
      div(class: "space-x-2") { @actions.each { |a| render a } } if @actions.any?
    end
  end
end
