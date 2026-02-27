class Components::PageHeader < Components::Base
  def initialize(title:, &actions)
    @title = title
    @actions = actions
  end

  def template
    div(class: "flex justify-between items-center mb-6") do
      h1(class: "text-2xl font-bold") { @title }
      if @actions
        div(class: "space-x-2", &@actions)
      end
    end
  end
end
