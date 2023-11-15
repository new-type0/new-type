require "test_helper"

class Admin::CunstomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_cunstomers_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_cunstomers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_cunstomers_edit_url
    assert_response :success
  end
end
