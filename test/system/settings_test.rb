require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:one)
  end

  test "visiting the index" do
    visit settings_url
    assert_selector "h1", text: "Settings"
  end

  test "creating a Setting" do
    visit settings_url
    click_on "New Setting"

    fill_in "Budget hours", with: @setting.budget_hours
    fill_in "Budget hours full", with: @setting.budget_hours_full
    fill_in "Consultation exam extramural", with: @setting.consultation_exam_extramural
    fill_in "Consultation exam full", with: @setting.consultation_exam_full
    fill_in "Consultation semester extramural", with: @setting.consultation_semester_extramural
    fill_in "Consultation semester full", with: @setting.consultation_semester_full
    fill_in "Contingent extramural", with: @setting.contingent_extramural
    fill_in "Contingent full", with: @setting.contingent_full
    fill_in "Contract hours extramural", with: @setting.contract_hours_extramural
    fill_in "Contract hours full", with: @setting.contract_hours_full
    fill_in "Course extramural", with: @setting.course_extramural
    fill_in "Course full", with: @setting.course_full
    fill_in "Discipline extramural", with: @setting.discipline_extramural
    fill_in "Discipline full", with: @setting.discipline_full
    fill_in "Exam full", with: @setting.exam_full
    fill_in "Exam v extramural", with: @setting.exam_v_extramural
    fill_in "Exam w extramural", with: @setting.exam_w_extramural
    fill_in "Laboratory classes extramural", with: @setting.laboratory_classes_extramural
    fill_in "Laboratory classes full", with: @setting.laboratory_classes_full
    fill_in "Lectures extramural", with: @setting.lectures_extramural
    fill_in "Lectures full", with: @setting.lectures_full
    fill_in "Practical classes extramural", with: @setting.practical_classes_extramural
    fill_in "Practical classes full", with: @setting.practical_classes_full
    fill_in "Semester full", with: @setting.semester_full
    fill_in "Subgroups extramural", with: @setting.subgroups_extramural
    fill_in "Subgroups full", with: @setting.subgroups_full
    fill_in "Test extramural", with: @setting.test_extramural
    fill_in "Test full", with: @setting.test_full
    fill_in "Training direction extramural", with: @setting.training_direction_extramural
    fill_in "Training direction full", with: @setting.training_direction_full
    fill_in "Work plan extramural", with: @setting.work_plan_extramural
    fill_in "Work plan full", with: @setting.work_plan_full
    click_on "Create Setting"

    assert_text "Setting was successfully created"
    click_on "Back"
  end

  test "updating a Setting" do
    visit settings_url
    click_on "Edit", match: :first

    fill_in "Budget hours", with: @setting.budget_hours
    fill_in "Budget hours full", with: @setting.budget_hours_full
    fill_in "Consultation exam extramural", with: @setting.consultation_exam_extramural
    fill_in "Consultation exam full", with: @setting.consultation_exam_full
    fill_in "Consultation semester extramural", with: @setting.consultation_semester_extramural
    fill_in "Consultation semester full", with: @setting.consultation_semester_full
    fill_in "Contingent extramural", with: @setting.contingent_extramural
    fill_in "Contingent full", with: @setting.contingent_full
    fill_in "Contract hours extramural", with: @setting.contract_hours_extramural
    fill_in "Contract hours full", with: @setting.contract_hours_full
    fill_in "Course extramural", with: @setting.course_extramural
    fill_in "Course full", with: @setting.course_full
    fill_in "Discipline extramural", with: @setting.discipline_extramural
    fill_in "Discipline full", with: @setting.discipline_full
    fill_in "Exam full", with: @setting.exam_full
    fill_in "Exam v extramural", with: @setting.exam_v_extramural
    fill_in "Exam w extramural", with: @setting.exam_w_extramural
    fill_in "Laboratory classes extramural", with: @setting.laboratory_classes_extramural
    fill_in "Laboratory classes full", with: @setting.laboratory_classes_full
    fill_in "Lectures extramural", with: @setting.lectures_extramural
    fill_in "Lectures full", with: @setting.lectures_full
    fill_in "Practical classes extramural", with: @setting.practical_classes_extramural
    fill_in "Practical classes full", with: @setting.practical_classes_full
    fill_in "Semester full", with: @setting.semester_full
    fill_in "Subgroups extramural", with: @setting.subgroups_extramural
    fill_in "Subgroups full", with: @setting.subgroups_full
    fill_in "Test extramural", with: @setting.test_extramural
    fill_in "Test full", with: @setting.test_full
    fill_in "Training direction extramural", with: @setting.training_direction_extramural
    fill_in "Training direction full", with: @setting.training_direction_full
    fill_in "Work plan extramural", with: @setting.work_plan_extramural
    fill_in "Work plan full", with: @setting.work_plan_full
    click_on "Update Setting"

    assert_text "Setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Setting" do
    visit settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Setting was successfully destroyed"
  end
end
