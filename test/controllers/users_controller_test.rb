require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # 5.4.1演習No.1
    # 5.4.2演習No.2 コメントアウト
    # 5.4.2演習No.2 コメントアウト解除
    get signup_path
    assert_response :success
  end
end
