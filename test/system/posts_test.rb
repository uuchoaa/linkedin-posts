# frozen_string_literal: true

require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  test "index displays posts" do
    visit root_path

    assert_text "Fixture Post Title"
    assert_link "Show"
    assert_link "New Post"
  end

  test "show post" do
    post = posts(:one)
    visit root_path

    click_link "Show", href: post_path(post)

    assert_selector "h1", text: post.title
    assert_text post.hook
  end

  test "new post has Back link" do
    visit new_post_path

    assert_link "Back", href: posts_path
    click_link "Back"
    assert_current_path posts_path
  end

  test "edit post has Back link" do
    post = posts(:one)
    visit edit_post_path(post)

    assert_link "Back", href: posts_path
    click_link "Back"
    assert_current_path posts_path
  end

  test "edit page loads after component reload" do
    post = posts(:one)
    visit edit_post_path(post)
    assert_text "Edit Post"

    # Simulate development reload (ErrorSummary lives under Rendering to avoid Phlex::Kit NameError)
    Components::Rendering.send(:remove_const, :ErrorSummary)
    load Rails.root.join("app/components/rendering/error_summary.rb").to_s

    visit edit_post_path(post)
    assert_text "Edit Post"
  end

  test "new post" do
    visit root_path
    click_link "New Post"

    assert_link "Back"

    fill_in "post_external_id", with: 2001
    fill_in "Title", with: "E2E Created Post"
    select "Design systems", from: "Category"
    select "Draft", from: "Status"
    fill_in "Skill level", with: "Senior"
    fill_in "Hook", with: "Test hook"
    fill_in "Content summary", with: "Test summary"
    fill_in "Senior insight", with: "Test insight"
    fill_in "Cta", with: "Test CTA"
    fill_in "Hashtags", with: "e2e test"

    click_button "Create Post"

    assert_text "Post was successfully created."
    assert_text "E2E Created Post"
  end

  test "edit post" do
    post = posts(:one)
    visit edit_post_path(post)

    assert_link "Back"

    fill_in "Title", with: "Updated Title"

    click_button "Update Post"

    assert_text "Post was successfully updated."
    assert_text "Updated Title"
  end

  test "destroy post" do
    post = posts(:one)
    visit root_path

    accept_confirm "Are you sure?" do
      click_link "Delete", href: post_path(post)
    end

    assert_text "Post was successfully deleted."
    assert_no_text "Fixture Post Title"
  end

  test "navbar is horizontal when layout strategy is stacked" do
    Cuy.configure { |c| c.layout.strategy = :stacked }
    visit root_path
    assert_selector "nav.inset-x-0"
  end

  test "navbar is vertical when layout strategy is sidebar" do
    Cuy.configure { |c| c.layout.strategy = :sidebar }
    begin
      visit root_path
      assert_selector "nav.left-0"
      assert_selector "nav.w-64"
    ensure
      Cuy.configure { |c| c.layout.strategy = :stacked }
    end
  end
end
