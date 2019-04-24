require 'test_helper'

class ResearchWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @research_work = research_works(:one)
  end

  test "should get index" do
    get research_works_url
    assert_response :success
  end

  test "should get new" do
    get new_research_work_url
    assert_response :success
  end

  test "should create research_work" do
    assert_difference('ResearchWork.count') do
      post research_works_url, params: { research_work: {  } }
    end

    assert_redirected_to research_work_url(ResearchWork.last)
  end

  test "should show research_work" do
    get research_work_url(@research_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_research_work_url(@research_work)
    assert_response :success
  end

  test "should update research_work" do
    patch research_work_url(@research_work), params: { research_work: {  } }
    assert_redirected_to research_work_url(@research_work)
  end

  test "should destroy research_work" do
    assert_difference('ResearchWork.count', -1) do
      delete research_work_url(@research_work)
    end

    assert_redirected_to research_works_url
  end
end
