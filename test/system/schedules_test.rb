require "application_system_test_case"

class SchedulesTest < ApplicationSystemTestCase
  setup do
    @schedule = schedules(:one)
  end

  test "visiting the index" do
    visit schedules_url
    assert_selector "h1", text: "Schedules"
  end

  test "should create schedule" do
    visit schedules_url
    click_on "New schedule"

    fill_in "Activity", with: @schedule.activity
    fill_in "Day of week", with: @schedule.day_of_week
    fill_in "End time", with: @schedule.end_time
    fill_in "Start time", with: @schedule.start_time
    click_on "Create Schedule"

    assert_text "Schedule was successfully created"
    click_on "Back"
  end

  test "should update Schedule" do
    visit schedule_url(@schedule)
    click_on "Edit this schedule", match: :first

    fill_in "Activity", with: @schedule.activity
    fill_in "Day of week", with: @schedule.day_of_week
    fill_in "End time", with: @schedule.end_time.to_s
    fill_in "Start time", with: @schedule.start_time.to_s
    click_on "Update Schedule"

    assert_text "Schedule was successfully updated"
    click_on "Back"
  end

  test "should destroy Schedule" do
    visit schedule_url(@schedule)
    click_on "Destroy this schedule", match: :first

    assert_text "Schedule was successfully destroyed"
  end
end
