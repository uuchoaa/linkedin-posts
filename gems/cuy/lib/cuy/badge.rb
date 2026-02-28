# frozen_string_literal: true

class Cuy::Badge < Cuy::Base
  VARIANTS = {
    success: "inline-flex items-center rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-800",
    warning: "inline-flex items-center rounded-full bg-yellow-100 px-2.5 py-0.5 text-xs font-medium text-yellow-800",
    info:    "inline-flex items-center rounded-full bg-blue-100 px-2.5 py-0.5 text-xs font-medium text-blue-800",
    neutral: "inline-flex items-center rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-medium text-gray-700"
  }.freeze

  def self.variant_for_status(status)
    {
      "idea"      => :neutral,
      "draft"     => :neutral,
      "ready"     => :info,
      "scheduled" => :warning,
      "published" => :success
    }.fetch(status.to_s, :neutral)
  end

  def initialize(variant: :neutral)
    @variant = variant
  end

  def view_template(&block)
    span(class: VARIANTS[@variant], &block)
  end
end
