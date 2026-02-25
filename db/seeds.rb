# frozen_string_literal: true

require "csv"

csv_path = Rails.root.join("assets", "posts-database.csv")
CSV.foreach(csv_path, headers: true) do |row|
  post = Post.find_or_initialize_by(external_id: row["ID"])
  category_key = row["Category"].to_s.parameterize.tr("-", "_")
  hashtags = row["Hashtags"].to_s.split

  post.assign_attributes(
    category: category_key,
    title: row["Post Title"],
    skill_level: row["Skill Level"],
    hook: row["Hook"],
    content_summary: row["Content Summary"],
    senior_insight: row["Senior Insight"],
    cta: row["CTA"],
    hashtags: hashtags,
    body: nil,
    status: :idea
  )
  post.save!
end
