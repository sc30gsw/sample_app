require "test_helper"
require "minitest/reporters"
Minitest::Reporters.use!

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # 3.4.4演習No.1
  test "should get root" do
    get root_url
    assert_response :success
  end


  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", @base_title
  end

  test "should get help" do
    # 5.3.2演習No.2
    # get helf_path
    # 5.3.2演習No.3
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end
end
