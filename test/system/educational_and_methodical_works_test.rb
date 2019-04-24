require "application_system_test_case"

class EducationalAndMethodicalWorksTest < ApplicationSystemTestCase
  setup do
    @educational_and_methodical_work = educational_and_methodical_works(:one)
  end

  test "visiting the index" do
    visit educational_and_methodical_works_url
    assert_selector "h1", text: "Educational And Methodical Works"
  end

  test "creating a Educational and methodical work" do
    visit educational_and_methodical_works_url
    click_on "New Educational And Methodical Work"

    click_on "Create Educational and methodical work"

    assert_text "Educational and methodical work was successfully created"
    click_on "Back"
  end

  test "updating a Educational and methodical work" do
    visit educational_and_methodical_works_url
    click_on "Edit", match: :first

    click_on "Update Educational and methodical work"

    assert_text "Educational and methodical work was successfully updated"
    click_on "Back"
  end

  test "destroying a Educational and methodical work" do
    visit educational_and_methodical_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Educational and methodical work was successfully destroyed"
  end
end
