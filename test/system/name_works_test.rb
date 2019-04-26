require "application_system_test_case"

class NameWorksTest < ApplicationSystemTestCase
  setup do
    @name_work = name_works(:one)
  end

  test "visiting the index" do
    visit name_works_url
    assert_selector "h1", text: "Name Works"
  end

  test "creating a Name work" do
    visit name_works_url
    click_on "New Name Work"

    fill_in "Name", with: @name_work.name
    click_on "Create Name work"

    assert_text "Name work was successfully created"
    click_on "Back"
  end

  test "updating a Name work" do
    visit name_works_url
    click_on "Edit", match: :first

    fill_in "Name", with: @name_work.name
    click_on "Update Name work"

    assert_text "Name work was successfully updated"
    click_on "Back"
  end

  test "destroying a Name work" do
    visit name_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Name work was successfully destroyed"
  end
end
