require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  should_have_named_scope :admins, :include => :roles, :conditions => "roles.name = 'admin'"

  should_validate_presence_of :login, :password, :password_confirmation, :email, :name

  def test_should_create_user
    assert_difference 'User.count' do
      user = Factory(:user)
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_reset_password
    user = Factory(:user)
    user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal user, User.authenticate(user.login, 'new password')
  end

  def test_should_not_rehash_password
    user = Factory(:user)
    user.update_attributes(:login => 'quentin2')
    assert_equal user, User.authenticate('quentin2', 'secret')
  end

  def test_should_authenticate_user
    user = Factory(:user)
    assert_equal user, User.authenticate(user.login, 'secret')
  end

  def test_should_set_remember_token
    user = Factory(:user)
    user.remember_me
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
  end

  def test_should_unset_remember_token
    user = Factory(:user)
    user.remember_me
    assert_not_nil user.remember_token
    user.forget_me
    assert_nil user.remember_token
  end

  def test_should_remember_me_for_one_week
    user = Factory(:user)
    before = 1.week.from_now.utc
    user.remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert user.remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    user = Factory(:user)
    time = 1.week.from_now.utc
    user.remember_me_until time
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert_equal user.remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    user = Factory(:user)
    before = 2.weeks.from_now.utc
    user.remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert user.remember_token_expires_at.between?(before, after)
  end

end
