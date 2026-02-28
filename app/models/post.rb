# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, optional: true
  enum :category, {
    modular_monoliths: 0,
    design_systems: 1,
    ai_integration: 2,
    elasticsearch: 3,
    aws: 4,
    database: 5,
    graphql: 6,
    docker: 7,
    ai_agents: 8,
    database_optimization: 9
  }

  enum :status, {
    idea: 0,
    draft: 1,
    ready: 2,
    scheduled: 3,
    published: 4
  }

  validates :external_id, presence: true, uniqueness: true
  validates :category, presence: true
  validates :title, presence: true
  validates :skill_level, presence: true
  validates :hook, presence: true
  validates :content_summary, presence: true
  validates :senior_insight, presence: true
  validates :cta, presence: true
  validates :hashtags, presence: true

  validates :status, inclusion: { in: statuses.keys }
end
