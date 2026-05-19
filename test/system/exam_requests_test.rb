require "application_system_test_case"

class ExamRequestsTest < ApplicationSystemTestCase
  setup do
    @exam_request = exam_requests(:one)
  end

  test "visiting the index" do
    visit exam_requests_url
    assert_selector "h1", text: "Exam requests"
  end

  test "should create exam request" do
    visit exam_requests_url
    click_on "New exam request"

    fill_in "Exam date", with: @exam_request.exam_date
    fill_in "Status", with: @exam_request.status
    fill_in "Student", with: @exam_request.student_id
    click_on "Create Exam request"

    assert_text "Exam request was successfully created"
    click_on "Back"
  end

  test "should update Exam request" do
    visit exam_request_url(@exam_request)
    click_on "Edit this exam request", match: :first

    fill_in "Exam date", with: @exam_request.exam_date
    fill_in "Status", with: @exam_request.status
    fill_in "Student", with: @exam_request.student_id
    click_on "Update Exam request"

    assert_text "Exam request was successfully updated"
    click_on "Back"
  end

  test "should destroy Exam request" do
    visit exam_request_url(@exam_request)
    click_on "Destroy this exam request", match: :first

    assert_text "Exam request was successfully destroyed"
  end
end
