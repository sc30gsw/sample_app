require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    # 5.3.4演習No.2
    get contact_path
    assert_select "title", full_title("Contact")
  end

  # 5.4.2演習No.3
  test "signup page access" do
    get signup_path
    assert_template 'users/new'
    assert_select "h1", "Sign up"
  end
end
