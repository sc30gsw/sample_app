require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # 5.4.1演習No.1
    get signup_path
    assert_response :success
  end
end
