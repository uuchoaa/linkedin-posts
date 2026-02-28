# frozen_string_literal: true

# Reopen Cuy::Base to add Rails helpers. Components in this app use Cuy::Base
# and get Routes, LinkTo, etc. when cuy-rails is loaded.
class Cuy::Base
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::Pluralize
  include Phlex::Rails::Helpers::Flash
end
