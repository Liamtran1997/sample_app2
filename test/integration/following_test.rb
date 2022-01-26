require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

  # test "following page" do
  #   get following_user_path(@user)
  #   assert_not @user.following.empty?
  #   assert_match @user.following.count.to_s, response.body
  #   @user.following.each do |user|
  #     assert_select "a[href=?]", user_path(user)
  #   end
  # end
  #
  # test "followers page" do
  #   get followers_user_path(@user)
  #   assert_not @user.followers.empty?
  #   assert_match @user.followers.count.to_s, response.body
  #   @user.followers.each do |user|
  #     assert_select "a[href=?]", user_path(user)
  #   end
  # end
  #
  #
  # # Tests for the follow and unfollow buttons.
  # test "should follow a user the standard way" do
  #   assert_difference '@user.following.count', 1 do
  #     post relationships_path, params: { followed_id: @other.id }
  #   end
  # end
  #
  # test "should follow a user with Ajax" do
  #   assert_difference '@user.following.count', 1 do
  #     post relationships_path, xhr: true, params: { followed_id: @other.id }
  #   end
  # end
  #
  # test "should unfollow a user the standard way" do
  #   @user.follow(@other)
  #   relationship = @user.active_relationships.find_by(followed_id: @other.id)
  #   assert_difference '@user.following.count', -1 do
  #     delete relationship_path(relationship)
  #   end
  # end
  #
  # test "should unfollow a user with Ajax" do
  #   @user.follow(@other)
  #   relationship = @user.active_relationships.find_by(followed_id: @other.id)
  #   assert_difference '@user.following.count', -1 do
  #     delete relationship_path(relationship), xhr: true
  #   end
  # end

end
