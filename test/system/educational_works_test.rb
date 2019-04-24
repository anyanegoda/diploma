require "application_system_test_case"

class EducationalWorksTest < ApplicationSystemTestCase
  setup do
    @educational_work = educational_works(:one)
  end

  test "visiting the index" do
    visit educational_works_url
    assert_selector "h1", text: "Educational Works"
  end

  test "creating a Educational work" do
    visit educational_works_url
    click_on "New Educational Work"

    click_on "Create Educational work"

    assert_text "Educational work was successfully created"
    click_on "Back"
  end

  test "updating a Educational work" do
    visit educational_works_url
    click_on "Edit", match: :first

    click_on "Update Educational work"

    assert_text "Educational work was successfully updated"
    click_on "Back"
  end

  test "destroying a Educational work" do
    visit educational_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Educational work was successfully destroyed"
  end
end
