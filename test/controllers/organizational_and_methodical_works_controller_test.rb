require 'test_helper'

class OrganizationalAndMethodicalWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organizational_and_methodical_work = organizational_and_methodical_works(:one)
  end

  test "should get index" do
    get organizational_and_methodical_works_url
    assert_response :success
  end

  test "should get new" do
    get new_organizational_and_methodical_work_url
    assert_response :success
  end

  test "should create organizational_and_methodical_work" do
    assert_difference('OrganizationalAndMethodicalWork.count') do
      post organizational_and_methodical_works_url, params: { organizational_and_methodical_work: {  } }
    end

    assert_redirected_to organizational_and_methodical_work_url(OrganizationalAndMethodicalWork.last)
  end

  test "should show organizational_and_methodical_work" do
    get organizational_and_methodical_work_url(@organizational_and_methodical_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_organizational_and_methodical_work_url(@organizational_and_methodical_work)
    assert_response :success
  end

  test "should update organizational_and_methodical_work" do
    patch organizational_and_methodical_work_url(@organizational_and_methodical_work), params: { organizational_and_methodical_work: {  } }
    assert_redirected_to organizational_and_methodical_work_url(@organizational_and_methodical_work)
  end

  test "should destroy organizational_and_methodical_work" do
    assert_difference('OrganizationalAndMethodicalWork.count', -1) do
      delete organizational_and_methodical_work_url(@organizational_and_methodical_work)
    end

    assert_redirected_to organizational_and_methodical_works_url
  end
end
