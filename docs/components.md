# Components

## UI Components

| Component | Helper | Purpose |
|-----------|--------|---------|
| `Cuy::Button` | `cuy_button` | primary, secondary, danger, ghost; supports `href`, `method`, `confirm` |
| `Cuy::Card` | `cuy_card` | Container with optional title, `padding: :normal \| :large` |
| `Cuy::Section` | `cuy_doc_section` | Doc section with id, title, description (for Storybook/docs) |
| `Cuy::Container` | `cuy_container` | Max-width wrapper, `max_width`, `spacing` |
| `Cuy::Flex` | `cuy_flex` | Flex layout, `wrap`, `gap` |
| `Cuy::Grid` | — | Grid with presets: `:two`, `:three`, `:four`, `:six`, `:stack` |
| `Cuy::Prose` | `cuy_prose` | Typography wrapper |
| `Cuy::InlineCode` | `cuy_inline_code` | Inline code styling |
| `Cuy::CodeBlock` | `cuy_code_block` | Collapsible code block |
| `Cuy::Badge` | — | Status badges |
| `Cuy::Select` | — | Select dropdown |
| `Cuy::Table` | — | Table with column builder |

## Form Components

| Component | Helper | Purpose |
|-----------|--------|---------|
| `Cuy::Form::Section` | `cuy_section` | Form section with title, description |
| `Cuy::Form::Grid` | `cuy_grid` | Responsive grid; `column(span:)` builder |
| `Cuy::Form::Actions` | `cuy_actions` | Button row; `submit`, `cancel`, `button` |

## Layout Components

- **Layout** — `Cuy::Layout` with `sidebar`, `top_bar`, `main`
- **Sidebar** — Dark/light nav, `brand`, `nav_section`, `nav_item`
- **TopBar** — Header with breadcrumb and right slot
- **PageHeader** — Title + action buttons via `with_action`
- **PageView** — Full page: navbar + header + main (Cuy::PageView)
- **Navbar** — Top nav bar
- **Main** — Content wrapper with optional sidebar context
