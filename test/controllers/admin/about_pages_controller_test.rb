require "test_helper"

class Admin::AboutPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_about_pages_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_about_pages_update_url
    assert_response :success
  end
end
