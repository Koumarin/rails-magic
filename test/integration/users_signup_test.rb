require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name:                  '',
                                       email:                 'user@invalid',
                                       password:              'foo',
                                       password_confirmation: 'bar'}}
    end

    assert_template 'users/new'         # We should return to the signup page.

    assert_select 'div#error_explanation' # The error messages should be
    assert_select 'div.alert-danger'      # displayed in the page.
  end

  test 'valid signup information' do
    assert_difference 'User.count', 1 do
      post users_path,
           params: {user: {name:                  'user',
                           email:                 'user@example.com',
                           password:              'password',
                           password_confirmation: 'password'}}
    end

    follow_redirect!                    # We should be redirected
    assert_template 'users/show'        # to the new user's page.
    assert_select 'div.alert-success'   # There should be a success message.
  end
end
