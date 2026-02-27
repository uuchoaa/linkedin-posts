class Components::FlashNotice < Components::Base
  def initialize(message:, tone: :notice)
    @message = message
    @tone = tone
  end

  def template
    classes = case @tone
              when :alert then "bg-red-100 text-red-700"
              else "bg-green-100 text-green-700"
              end

    p(class: "mb-4 rounded-lg p-4 #{classes}") { @message }
  end
end
