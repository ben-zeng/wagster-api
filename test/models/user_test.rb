require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user with a valid email' do
    user = User.new(email: 'test@email.com', password_digest: 'password')
    assert user.valid?
  end

  test 'user with invalid email should fail' do
    user = User.new(email: 'not an email', password_digest: 'password')
    assert_not user.valid?
  end

  test 'user with taken email should fail' do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: 'test')
    assert_not user.valid?
  end

end
