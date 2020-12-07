require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "user", email: "user@alphablog.com", password: "password")
    @travel_category = Category.create(name: "Travel")
    @food_category = Category.create(name: "Food")
    sign_in(@user)
  end
  
  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference('Article.count', 1) do
      post articles_path, params: { article: { title: "Sample title", description: "Sample description", category_ids: [@travel_category.id, @food_category.id]} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sample title", response.body
  end

  test "get new article form and reject invalid article submission" do
    get '/articles/new'
    assert_response :success
    assert_no_difference("Article.count") do
      post articles_path, params: {article: {title: " "}}
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
