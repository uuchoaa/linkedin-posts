# frozen_string_literal: true

class Cuy::IndexView < Cuy::PageView
  def self.model_class(klass = nil)
    klass ? @model_class = klass : @model_class
  end

  def initialize(collection:, params: {})
    @collection = collection
    @params = params
    @model_class = self.class.model_class
  end

  def navbar = render Cuy::Navbar.new

  def page_header
    render Cuy::PageHeader.new(title: page_title)
      .with_action(Cuy::Button.new(href: new_resource_path) {
        "New #{@model_class.model_name.human}"
      })
  end

  def main_content
    render Cuy::ModelFilterBar.new(
      model: @model_class,
      url: resource_index_path,
      params: @params
    )
    render Cuy::ModelTable.new(@collection, presenter: inferred_presenter)
  end

  private

  def page_title
    @model_class.model_name.human(count: 2)
  end

  def resource_index_path
    route_key = @model_class.model_name.route_key
    helpers.public_send(:"#{route_key}_path")
  end

  def new_resource_path
    singular_route_key = @model_class.model_name.singular_route_key
    helpers.public_send(:"new_#{singular_route_key}_path")
  end

  def inferred_presenter
    klass_name = "#{@model_class.name.pluralize}::TablePresenter"
    klass_name.constantize.new if Object.const_defined?(klass_name)
  end
end
