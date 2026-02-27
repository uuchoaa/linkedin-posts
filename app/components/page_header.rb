class Components::PageHeader < Components::Base
  def initialize(title:)
    @title = title
  end

  def view_template(&actions)
    div(class: "flex justify-between items-center mb-6") do
      h1(class: "text-2xl font-bold") { @title }
      div(class: "space-x-2", &actions) if actions
    end
  end
end
