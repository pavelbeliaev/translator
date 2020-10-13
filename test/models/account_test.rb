require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'validate presence of lang' do
    assert validate_presence_of(:lang)
  end

  test 'has one user' do
    assert have_one(:user)
  end
end
