require "application_system_test_case"

class OrganizationalAndMethodicalWorksTest < ApplicationSystemTestCase
  setup do
    @organizational_and_methodical_work = organizational_and_methodical_works(:one)
  end

  test "visiting the index" do
    visit organizational_and_methodical_works_url
    assert_selector "h1", text: "Organizational And Methodical Works"
  end

  test "creating a Organizational and methodical work" do
    visit organizational_and_methodical_works_url
    click_on "New Organizational And Methodical Work"

    click_on "Create Organizational and methodical work"

    assert_text "Organizational and methodical work was successfully created"
    click_on "Back"
  end

  test "updating a Organizational and methodical work" do
    visit organizational_and_methodical_works_url
    click_on "Edit", match: :first

    click_on "Update Organizational and methodical work"

    assert_text "Organizational and methodical work was successfully updated"
    click_on "Back"
  end

  test "destroying a Organizational and methodical work" do
    visit organizational_and_methodical_works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Organizational and methodical work was successfully destroyed"
  end
end
