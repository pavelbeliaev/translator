require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'validate presence of email' do
    assert validate_presence_of(:email)
  end

  test 'belongs to account' do
    assert belong_to(:account)
  end

  test 'creates user with a default account' do
    user = User.create(
      email: 'bilbo@shire.com',
      password: 'password',
      password_confirmation: 'password'
    )

    assert_not_nil(user.account)
  end

  test 'create user with a passed account' do
    account = Account.create
    user = User.create(
      email: 'bilbo@shire.com',
      password: 'password',
      password_confirmation: 'password',
      account: account
    )

    assert_same(account, user.account)
  end
end
