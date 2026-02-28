# LinkedInPosts

Mock Rails app incubating the **Cuy** design system (Phlex components).

## Gems

- **cuy** (`gems/cuy`) v0.1.0 — Components, helpers, layout. Use with Sinatra, Rack, or cuy-rails.
- **cuy-rails** (`gems/cuy-rails`) — Rails: AR inference, route helpers, IndexView, ModelTable.

## Docs

See [`docs/`](docs/) for concepts:

- [Overview](docs/overview.md)
- [Components](docs/components.md)
- [Helpers](docs/helpers.md)
- [Layout](docs/layout.md)
- [Phlexbook](docs/phlexbook.md)
- [Next steps](docs/next-steps.md)

## Getting started

```bash
bundle install
rails db:create db:migrate
rails server
```

Phlexbook (component docs): `cd apps/phlexbook && bundle exec rackup`
