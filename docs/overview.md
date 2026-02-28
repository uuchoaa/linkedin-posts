# Cuy Design System — Overview

**Cuy** is a framework-agnostic design system built with [Phlex](https://phlex.fun). Components produce HTML and work with Sinatra, Rack, or **cuy-rails** for Rails.

## Structure

- **cuy** (`gems/cuy`) — Core components, helpers, layout
- **cuy-rails** (`gems/cuy-rails`) — Rails integration: AR inference, route helpers, IndexView, ModelTable
- **phlexbook** (`apps/phlexbook`) — Storybook-like component docs (Sinatra)

## Key concepts

1. **Components** — Phlex views (e.g. `Cuy::Button`, `Cuy::Card`)
2. **Helpers** — Shortcuts that render components (`cuy_button`, `cuy_card`, etc.)
3. **Helper registration** — `cuy_helper :cuy_button` declared in the component file
4. **Layout** — `Cuy::Layout` with sidebar, top bar, main content slots
5. **PageView** — Full-page layout (navbar + header + main) for app screens
