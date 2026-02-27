# frozen_string_literal: true

class Post < ApplicationRecord
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
end
