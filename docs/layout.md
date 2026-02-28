# Layout

## Cuy::Layout DSL

```ruby
render Cuy::Layout.new(title: "App", sidebar: :dark) do |l|
  l.sidebar do
    l.brand "App", suffix: "DS"
    l.nav_section "Components" do
      l.nav_item "Button", "#", active: true
    end
  end
  l.top_bar breadcrumb: [ "Section", "Page" ], right: "Helper: cuy_button"
  l.main do
    # content
  end
end
```

- **sidebar** — Optional. `:dark` or `:light` theme. Build with `brand`, `nav_section`, `nav_item`.
- **top_bar** — Breadcrumb array + right-side string or block.
- **main** — Main content area.

## PageView

`Cuy::PageView` (and `Cuy::Rails::PageView` in cuy-rails) provide a full-page layout with navbar, header, and main. Override `navbar`, `page_header`, `main_content`, `aside_content` in subclasses.
