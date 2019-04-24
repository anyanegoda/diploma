require 'test_helper'

class EducationalWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @educational_work = educational_works(:one)
  end

  test "should get index" do
    get educational_works_url
    assert_response :success
  end

  test "should get new" do
    get new_educational_work_url
    assert_response :success
  end

  test "should create educational_work" do
    assert_difference('EducationalWork.count') do
      post educational_works_url, params: { educational_work: {  } }
    end

    assert_redirected_to educational_work_url(EducationalWork.last)
  end

  test "should show educational_work" do
    get educational_work_url(@educational_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_educational_work_url(@educational_work)
    assert_response :success
  end

  test "should update educational_work" do
    patch educational_work_url(@educational_work), params: { educational_work: {  } }
    assert_redirected_to educational_work_url(@educational_work)
  end

  test "should destroy educational_work" do
    assert_difference('EducationalWork.count', -1) do
      delete educational_work_url(@educational_work)
    end

    assert_redirected_to educational_works_url
  end
end
