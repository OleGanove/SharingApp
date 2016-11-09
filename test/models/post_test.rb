require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(email: "hallo@gmx.de")
    @post = @user.posts.build(title: "Lorem ipsum", description: "Voll spannend", link: "www.google.de")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do 
    @post.user_id = nil
    assert_not @post.valid?
  end
end
