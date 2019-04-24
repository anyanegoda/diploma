require 'test_helper'

class EducationalAndMethodicalWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @educational_and_methodical_work = educational_and_methodical_works(:one)
  end

  test "should get index" do
    get educational_and_methodical_works_url
    assert_response :success
  end

  test "should get new" do
    get new_educational_and_methodical_work_url
    assert_response :success
  end

  test "should create educational_and_methodical_work" do
    assert_difference('EducationalAndMethodicalWork.count') do
      post educational_and_methodical_works_url, params: { educational_and_methodical_work: {  } }
    end

    assert_redirected_to educational_and_methodical_work_url(EducationalAndMethodicalWork.last)
  end

  test "should show educational_and_methodical_work" do
    get educational_and_methodical_work_url(@educational_and_methodical_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_educational_and_methodical_work_url(@educational_and_methodical_work)
    assert_response :success
  end

  test "should update educational_and_methodical_work" do
    patch educational_and_methodical_work_url(@educational_and_methodical_work), params: { educational_and_methodical_work: {  } }
    assert_redirected_to educational_and_methodical_work_url(@educational_and_methodical_work)
  end

  test "should destroy educational_and_methodical_work" do
    assert_difference('EducationalAndMethodicalWork.count', -1) do
      delete educational_and_methodical_work_url(@educational_and_methodical_work)
    end

    assert_redirected_to educational_and_methodical_works_url
  end
end
