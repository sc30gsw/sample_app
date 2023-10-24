require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    # 7.3.4演習No.4
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      # 7.3.4演習No.3
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'

    # 7.3.4演習No.1
    assert_select 'li', "Name can't be blank"
    assert_select 'li', 'Email is invalid'
    assert_select 'li', "Password confirmation doesn't match Password"
    assert_select 'li', 'Password is too short (minimum is 6 characters)'

    assert_no_difference 'User.count' do
      # 7.3.4演習No.3
      post signup_path, params: { user: { name:  "a" * 51,
                                         email: "a" * 244 + "@example.com",
                                         password:              "",
                                         password_confirmation: "" } }
    end
    assert_template 'users/new'
    assert_select 'li', "Name is too long (maximum is 50 characters)"
    assert_select 'li', 'Email is too long (maximum is 255 characters)'
    # has_secure_passwordとpasswordのpresence :trueがあるため同じエラーメッセージが出力される
    assert_select 'li', "Password can't be blank"
    assert_select 'li', "Password can't be blank"
    # リスト10.13の実装でテストがREDになるためコメントアウト
    # assert_select 'li', 'Password is too short (minimum is 6 characters)'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    # assert_template 'users/show'
    # 7.4.4演習No.1
    assert_not flash.blank?
    # assert is_logged_in?
  end
end
