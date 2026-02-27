class Components::PostReferenceCard < Components::Base
  def initialize(post:)
    @post = post
  end

  def view_template
    div(class: "mb-6 rounded-lg border border-gray-200 bg-gray-50 p-4") do
      h2(class: "text-sm font-semibold text-gray-600 uppercase tracking-wide mb-3") { "Reference" }

      dl(class: "space-y-3 text-sm") do
        reference_item("Hook", @post.hook)
        reference_item("Content Summary", @post.content_summary, multiline: true)
        reference_item("Senior Insight", @post.senior_insight)
        reference_item("CTA", @post.cta)

        if @post.hashtags.present?
          div do
            dt(class: "font-medium text-gray-500") { "Hashtags" }
            dd(class: "mt-0.5 text-gray-900") { @post.hashtags.join(" ") }
          end
        end
      end
    end
  end

  private

  def reference_item(label, value, multiline: false)
    return if value.blank?

    classes = ["mt-0.5 text-gray-900"]
    classes << "whitespace-pre-wrap" if multiline

    div do
      dt(class: "font-medium text-gray-500") { label }
      dd(class: classes.join(" ")) { value }
    end
  end
end
