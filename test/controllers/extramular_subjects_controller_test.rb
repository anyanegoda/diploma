require 'test_helper'

class ExtramularSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extramular_subject = extramular_subjects(:one)
  end

  test "should get index" do
    get extramular_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_extramular_subject_url
    assert_response :success
  end

  test "should create extramular_subject" do
    assert_difference('ExtramularSubject.count') do
      post extramular_subjects_url, params: { extramular_subject: { consultation_exam_b: @extramular_subject.consultation_exam_b, consultation_exam_c: @extramular_subject.consultation_exam_c, consultation_semester_b: @extramular_subject.consultation_semester_b, consultation_semester_c: @extramular_subject.consultation_semester_c, course: @extramular_subject.course, exam_b: @extramular_subject.exam_b, exam_c: @extramular_subject.exam_c, group_quantity: @extramular_subject.group_quantity, laboratory_classes: @extramular_subject.laboratory_classes, lectures: @extramular_subject.lectures, modular_control_b: @extramular_subject.modular_control_b, modular_control_c: @extramular_subject.modular_control_c, practical_classes: @extramular_subject.practical_classes, semester: @extramular_subject.semester, student_b_quantity: @extramular_subject.student_b_quantity, student_c_quantity: @extramular_subject.student_c_quantity, subject_name: @extramular_subject.subject_name, test_b: @extramular_subject.test_b, test_c: @extramular_subject.test_c, training_direction: @extramular_subject.training_direction } }
    end

    assert_redirected_to extramular_subject_url(ExtramularSubject.last)
  end

  test "should show extramular_subject" do
    get extramular_subject_url(@extramular_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_extramular_subject_url(@extramular_subject)
    assert_response :success
  end

  test "should update extramular_subject" do
    patch extramular_subject_url(@extramular_subject), params: { extramular_subject: { consultation_exam_b: @extramular_subject.consultation_exam_b, consultation_exam_c: @extramular_subject.consultation_exam_c, consultation_semester_b: @extramular_subject.consultation_semester_b, consultation_semester_c: @extramular_subject.consultation_semester_c, course: @extramular_subject.course, exam_b: @extramular_subject.exam_b, exam_c: @extramular_subject.exam_c, group_quantity: @extramular_subject.group_quantity, laboratory_classes: @extramular_subject.laboratory_classes, lectures: @extramular_subject.lectures, modular_control_b: @extramular_subject.modular_control_b, modular_control_c: @extramular_subject.modular_control_c, practical_classes: @extramular_subject.practical_classes, semester: @extramular_subject.semester, student_b_quantity: @extramular_subject.student_b_quantity, student_c_quantity: @extramular_subject.student_c_quantity, subject_name: @extramular_subject.subject_name, test_b: @extramular_subject.test_b, test_c: @extramular_subject.test_c, training_direction: @extramular_subject.training_direction } }
    assert_redirected_to extramular_subject_url(@extramular_subject)
  end

  test "should destroy extramular_subject" do
    assert_difference('ExtramularSubject.count', -1) do
      delete extramular_subject_url(@extramular_subject)
    end

    assert_redirected_to extramular_subjects_url
  end
end
