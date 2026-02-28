# Phlexbook

Storybook-style docs for Cuy components. Sinatra app at `apps/phlexbook`.

## Run

```bash
cd apps/phlexbook && bundle exec rackup
```

Open `http://localhost:9292`.

## Structure

- **Phlexbook::Layout** — Extends `Cuy::Layout`, adds Tailwind CDN
- **Phlexbook::ButtonPage** — Button component docs with Default, Variants, As link
- **Phlexbook::HelperRegistrationDisplay** — Renders `cuy_helper_names` from a component class

## Adding a page

1. Create `views/component_page.rb` with Layout + content
2. Add route in `app.rb`
3. Add nav item in Layout sidebar
