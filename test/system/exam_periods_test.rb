require "application_system_test_case"

class ExamPeriodsTest < ApplicationSystemTestCase
  setup do
    @exam_period = exam_periods(:one)
  end

  test "visiting the index" do
    visit exam_periods_url
    assert_selector "h1", text: "Exam periods"
  end

  test "should create exam period" do
    visit exam_periods_url
    click_on "New exam period"

    fill_in "Exam type", with: @exam_period.exam_type
    fill_in "Stage", with: @exam_period.stage
    click_on "Create Exam period"

    assert_text "Exam period was successfully created"
    click_on "Back"
  end

  test "should update Exam period" do
    visit exam_period_url(@exam_period)
    click_on "Edit this exam period", match: :first

    fill_in "Exam type", with: @exam_period.exam_type
    fill_in "Stage", with: @exam_period.stage
    click_on "Update Exam period"

    assert_text "Exam period was successfully updated"
    click_on "Back"
  end

  test "should destroy Exam period" do
    visit exam_period_url(@exam_period)
    click_on "Destroy this exam period", match: :first

    assert_text "Exam period was successfully destroyed"
  end
end
