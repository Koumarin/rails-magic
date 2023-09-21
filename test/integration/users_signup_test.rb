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
end
