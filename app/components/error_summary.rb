class Components::ErrorSummary < Components::Base
  def initialize(resource:)
    @resource = resource
  end

  def view_template
    return unless @resource.errors.any?

    div(class: "rounded-lg bg-red-50 p-4 text-red-700") do
      h2(class: "font-medium") do
        "#{pluralize(@resource.errors.count, 'error')} prohibited this #{@resource.model_name.human.downcase} from being saved:"
      end

      ul(class: "mt-2 list-disc list-inside") do
        @resource.errors.full_messages.each do |msg|
          li { msg }
        end
      end
    end
  end
end
