require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new
  end

  test "get new sign-up form and create new user" do
    get "/signup"
    assert_response :success
    assert_difference("User.count", 1) do
      post users_path, params: {user: {username: "admin", email: "admin@example.com", password: "password"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "admin", response.body
  end

  test "get new sign-up form and reject invalid user submission" do
    get '/signup'
    assert_response :success
    assert_no_difference("User.count") do
      post users_path, params: {user: {username: " "}}
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
