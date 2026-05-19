require "test_helper"

class ExamRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam_request = exam_requests(:one)
  end

  test "should get index" do
    get exam_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_request_url
    assert_response :success
  end

  test "should create exam_request" do
    assert_difference("ExamRequest.count") do
      post exam_requests_url, params: { exam_request: { exam_date: @exam_request.exam_date, status: @exam_request.status, student_id: @exam_request.student_id } }
    end

    assert_redirected_to exam_request_url(ExamRequest.last)
  end

  test "should show exam_request" do
    get exam_request_url(@exam_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_request_url(@exam_request)
    assert_response :success
  end

  test "should update exam_request" do
    patch exam_request_url(@exam_request), params: { exam_request: { exam_date: @exam_request.exam_date, status: @exam_request.status, student_id: @exam_request.student_id } }
    assert_redirected_to exam_request_url(@exam_request)
  end

  test "should destroy exam_request" do
    assert_difference("ExamRequest.count", -1) do
      delete exam_request_url(@exam_request)
    end

    assert_redirected_to exam_requests_url
  end
end
