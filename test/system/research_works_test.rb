require "application_system_test_case"

class ResearchWorksTest < ApplicationSystemTestCase
  setup do
    @research_work = research_works(:one)
  end

  test "visiting the index" do
    visit research_works_url
    assert_selector "h1", text: "Research Works"
  end

  test "creating a Research work" do
    visit research_works_url
    click_on "New Research Work"

    click_on "Create Research work"

    assert_text "Research work was successfully created"
    click_on "Back"
  end

  test "updating a Research work" do
    visit research_works_url
    click_on "Edit", match: :first

    click_on "Update Research work"

    assert_text "Research work was successfully updated"
    click_on "Back"
  end

  test "destroying a Research work" do
    visit research_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Research work was successfully destroyed"
  end
end
