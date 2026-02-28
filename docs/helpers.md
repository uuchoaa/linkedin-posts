# Helpers

## Usage

Helpers are included in `Cuy::Base`, `Components::Base`, and `ApplicationHelper`. Use them in Phlex views and ERB:

```ruby
cuy_button { "Save" }
cuy_button(variant: :secondary, href: posts_path) { "Back" }
cuy_card(title: "Overview") { ... }
cuy_section(title: "Post", description: "Basic info") { ... }
cuy_grid(cols: { base: 1, sm: 6 }) do |grid|
  grid.column(span: :full) { ... }
end
```

## Registration

Each component declares its helper via `cuy_helper` in the component file:

```ruby
class Cuy::Button < Cuy::Base
  cuy_helper :cuy_button
  # ...
end
```

Phlexbook displays this so you can discover helpers when browsing components.

## Modules

- **Cuy::Form::Helpers** — `cuy_section`, `cuy_grid`, `cuy_actions`
- **Cuy::UiHelpers** — `cuy_container`, `cuy_card`, `cuy_doc_section`, `cuy_flex`, `cuy_prose`, `cuy_inline_code`, `cuy_code_block`, `cuy_button`
- **Cuy::Helpers** — Includes both
