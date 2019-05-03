require "application_system_test_case"

class ExtramularSubjectsTest < ApplicationSystemTestCase
  setup do
    @extramular_subject = extramular_subjects(:one)
  end

  test "visiting the index" do
    visit extramular_subjects_url
    assert_selector "h1", text: "Extramular Subjects"
  end

  test "creating a Extramular subject" do
    visit extramular_subjects_url
    click_on "New Extramular Subject"

    fill_in "Consultation exam b", with: @extramular_subject.consultation_exam_b
    fill_in "Consultation exam c", with: @extramular_subject.consultation_exam_c
    fill_in "Consultation semester b", with: @extramular_subject.consultation_semester_b
    fill_in "Consultation semester c", with: @extramular_subject.consultation_semester_c
    fill_in "Course", with: @extramular_subject.course
    fill_in "Exam b", with: @extramular_subject.exam_b
    fill_in "Exam c", with: @extramular_subject.exam_c
    fill_in "Group quantity", with: @extramular_subject.group_quantity
    fill_in "Laboratory classes", with: @extramular_subject.laboratory_classes
    fill_in "Lectures", with: @extramular_subject.lectures
    fill_in "Modular control b", with: @extramular_subject.modular_control_b
    fill_in "Modular control c", with: @extramular_subject.modular_control_c
    fill_in "Practical classes", with: @extramular_subject.practical_classes
    fill_in "Semester", with: @extramular_subject.semester
    fill_in "Student b quantity", with: @extramular_subject.student_b_quantity
    fill_in "Student c quantity", with: @extramular_subject.student_c_quantity
    fill_in "Subject name", with: @extramular_subject.subject_name
    fill_in "Test b", with: @extramular_subject.test_b
    fill_in "Test c", with: @extramular_subject.test_c
    fill_in "Training direction", with: @extramular_subject.training_direction
    click_on "Create Extramular subject"

    assert_text "Extramular subject was successfully created"
    click_on "Back"
  end

  test "updating a Extramular subject" do
    visit extramular_subjects_url
    click_on "Edit", match: :first

    fill_in "Consultation exam b", with: @extramular_subject.consultation_exam_b
    fill_in "Consultation exam c", with: @extramular_subject.consultation_exam_c
    fill_in "Consultation semester b", with: @extramular_subject.consultation_semester_b
    fill_in "Consultation semester c", with: @extramular_subject.consultation_semester_c
    fill_in "Course", with: @extramular_subject.course
    fill_in "Exam b", with: @extramular_subject.exam_b
    fill_in "Exam c", with: @extramular_subject.exam_c
    fill_in "Group quantity", with: @extramular_subject.group_quantity
    fill_in "Laboratory classes", with: @extramular_subject.laboratory_classes
    fill_in "Lectures", with: @extramular_subject.lectures
    fill_in "Modular control b", with: @extramular_subject.modular_control_b
    fill_in "Modular control c", with: @extramular_subject.modular_control_c
    fill_in "Practical classes", with: @extramular_subject.practical_classes
    fill_in "Semester", with: @extramular_subject.semester
    fill_in "Student b quantity", with: @extramular_subject.student_b_quantity
    fill_in "Student c quantity", with: @extramular_subject.student_c_quantity
    fill_in "Subject name", with: @extramular_subject.subject_name
    fill_in "Test b", with: @extramular_subject.test_b
    fill_in "Test c", with: @extramular_subject.test_c
    fill_in "Training direction", with: @extramular_subject.training_direction
    click_on "Update Extramular subject"

    assert_text "Extramular subject was successfully updated"
    click_on "Back"
  end

  test "destroying a Extramular subject" do
    visit extramular_subjects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Extramular subject was successfully destroyed"
  end
end
