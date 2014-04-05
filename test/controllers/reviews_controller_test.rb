require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
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

  test "should create review" do
    assert_difference('Review.count') do
      post :create, review: {title: 'tests', poster:'ed'}
    end

    assert_redirected_to review_path(assigns(:review))
  end

  test "should show review" do
    get :show, id: @review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @review
    assert_response :success
  end

  test "should update review" do
    patch :update, id: reviews(:one).id, review: { title: 'test', poster: 'celi999' }
    assert_redirected_to review_path(assigns(:review))
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
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
