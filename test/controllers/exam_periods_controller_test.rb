require "test_helper"

class ExamPeriodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_period = exam_periods(:one)
  end

  test "should get index" do
    get exam_periods_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_period_url
    assert_response :success
  end

  test "should create exam_period" do
    assert_difference("ExamPeriod.count") do
      post exam_periods_url, params: { exam_period: { exam_type: @exam_period.exam_type, stage: @exam_period.stage } }
    end

    assert_redirected_to exam_period_url(ExamPeriod.last)
  end

  test "should show exam_period" do
    get exam_period_url(@exam_period)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_period_url(@exam_period)
    assert_response :success
  end

  test "should update exam_period" do
    patch exam_period_url(@exam_period), params: { exam_period: { exam_type: @exam_period.exam_type, stage: @exam_period.stage } }
    assert_redirected_to exam_period_url(@exam_period)
  end

  test "should destroy exam_period" do
    assert_difference("ExamPeriod.count", -1) do
      delete exam_period_url(@exam_period)
    end

    assert_redirected_to exam_periods_url
  end
end
