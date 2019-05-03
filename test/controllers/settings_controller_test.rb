require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get settings_url
    assert_response :success
  end

  test "should get new" do
    get new_setting_url
    assert_response :success
  end

  test "should create setting" do
    assert_difference('Setting.count') do
      post settings_url, params: { setting: { budget_hours: @setting.budget_hours, budget_hours_full: @setting.budget_hours_full, consultation_exam_extramural: @setting.consultation_exam_extramural, consultation_exam_full: @setting.consultation_exam_full, consultation_semester_extramural: @setting.consultation_semester_extramural, consultation_semester_full: @setting.consultation_semester_full, contingent_extramural: @setting.contingent_extramural, contingent_full: @setting.contingent_full, contract_hours_extramural: @setting.contract_hours_extramural, contract_hours_full: @setting.contract_hours_full, course_extramural: @setting.course_extramural, course_full: @setting.course_full, discipline_extramural: @setting.discipline_extramural, discipline_full: @setting.discipline_full, exam_full: @setting.exam_full, exam_v_extramural: @setting.exam_v_extramural, exam_w_extramural: @setting.exam_w_extramural, laboratory_classes_extramural: @setting.laboratory_classes_extramural, laboratory_classes_full: @setting.laboratory_classes_full, lectures_extramural: @setting.lectures_extramural, lectures_full: @setting.lectures_full, practical_classes_extramural: @setting.practical_classes_extramural, practical_classes_full: @setting.practical_classes_full, semester_full: @setting.semester_full, subgroups_extramural: @setting.subgroups_extramural, subgroups_full: @setting.subgroups_full, test_extramural: @setting.test_extramural, test_full: @setting.test_full, training_direction_extramural: @setting.training_direction_extramural, training_direction_full: @setting.training_direction_full, work_plan_extramural: @setting.work_plan_extramural, work_plan_full: @setting.work_plan_full } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show setting" do
    get setting_url(@setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    patch setting_url(@setting), params: { setting: { budget_hours: @setting.budget_hours, budget_hours_full: @setting.budget_hours_full, consultation_exam_extramural: @setting.consultation_exam_extramural, consultation_exam_full: @setting.consultation_exam_full, consultation_semester_extramural: @setting.consultation_semester_extramural, consultation_semester_full: @setting.consultation_semester_full, contingent_extramural: @setting.contingent_extramural, contingent_full: @setting.contingent_full, contract_hours_extramural: @setting.contract_hours_extramural, contract_hours_full: @setting.contract_hours_full, course_extramural: @setting.course_extramural, course_full: @setting.course_full, discipline_extramural: @setting.discipline_extramural, discipline_full: @setting.discipline_full, exam_full: @setting.exam_full, exam_v_extramural: @setting.exam_v_extramural, exam_w_extramural: @setting.exam_w_extramural, laboratory_classes_extramural: @setting.laboratory_classes_extramural, laboratory_classes_full: @setting.laboratory_classes_full, lectures_extramural: @setting.lectures_extramural, lectures_full: @setting.lectures_full, practical_classes_extramural: @setting.practical_classes_extramural, practical_classes_full: @setting.practical_classes_full, semester_full: @setting.semester_full, subgroups_extramural: @setting.subgroups_extramural, subgroups_full: @setting.subgroups_full, test_extramural: @setting.test_extramural, test_full: @setting.test_full, training_direction_extramural: @setting.training_direction_extramural, training_direction_full: @setting.training_direction_full, work_plan_extramural: @setting.work_plan_extramural, work_plan_full: @setting.work_plan_full } }
    assert_redirected_to setting_url(@setting)
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete setting_url(@setting)
    end

    assert_redirected_to settings_url
  end
end
