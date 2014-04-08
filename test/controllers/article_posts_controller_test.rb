require 'test_helper'

class ArticlePostsControllerTest < ActionController::TestCase
  setup do
    @article_post = reviews(:one)
  end

  test "should get index" do
    get :index, {},user_id: "celi999"
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should get new" do
    get :new, {}, user_id: "celi999"
    assert_response :success
  end

  test "should create article_post" do
    assert_difference('article_post.count') do
      post :create, article_post: {title: 'tests', poster:'ed'}
    end

    assert_redirected_to review_path(assigns(:article_post))
  end

  test "should show article_post" do
    get :show, id: @article_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_post
    assert_response :success
  end

  test "should update article_post" do
    patch :update, id: reviews(:one).id, article_post: { title: 'test', poster: 'celi999' }
    assert_redirected_to review_path(assigns(:article_post))
  end

  test "should destroy article_post" do
    assert_difference('article_post.count', -1) do
      delete :destroy, id: @article_post
    end

    assert_redirected_to reviews_path
  end

  #Create a duplicate user and test for failure
  test "should reject duplicate user creation" do
    user1 = User.new( :userid => "test",
      :password => "testing",
      :fullname => "Ima Test",
      :email => "test@myhost.com")
                              
    user2 = User.new(:userid => "test",
     :password => "testing",
     :fullname => "Ima Test Too",
     :email => "test@myhost.com")

    post :newuser, user: user1
    post :newuser, user: user2
    assert_response 302#we want this test to fail, if it does, returns TRUE and thus no error.  302 is fail code.
  end
end
