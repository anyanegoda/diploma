require 'test_helper'

class NameWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @name_work = name_works(:one)
  end

  test "should get index" do
    get name_works_url
    assert_response :success
  end

  test "should get new" do
    get new_name_work_url
    assert_response :success
  end

  test "should create name_work" do
    assert_difference('NameWork.count') do
      post name_works_url, params: { name_work: { name: @name_work.name } }
    end

    assert_redirected_to name_work_url(NameWork.last)
  end

  test "should show name_work" do
    get name_work_url(@name_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_name_work_url(@name_work)
    assert_response :success
  end

  test "should update name_work" do
    patch name_work_url(@name_work), params: { name_work: { name: @name_work.name } }
    assert_redirected_to name_work_url(@name_work)
  end

  test "should destroy name_work" do
    assert_difference('NameWork.count', -1) do
      delete name_work_url(@name_work)
    end

    assert_redirected_to name_works_url
  end
end
