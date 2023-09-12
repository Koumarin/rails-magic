require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new name: 'Example', email: 'user@example.com'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 21
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com' # Should have at most 255 chars.
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    addresses = %w[user@example.com  USER@foo.COM     A_US-ER@foo.bar.org
                   first.last@foo.jp alice+bob@baz.cn]
    addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    addresses = %w[user@example,com user_at_foo.org user.name@example.
                   foo@bar_baz.com  foo@bar+baz.com user@example..com]
    addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test 'email should be saved downcased' do
    uppercase_email = 'USER@EXAMPLE.COM'
    @user.email = uppercase_email
    @user.save
    assert_equal uppercase_email.downcase, @user.reload.email
  end
end
