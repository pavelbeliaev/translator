require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'validation of to_lang' do
    assert validate_presence_of(:to_lang)
    assert validate_inclusion_of(:to_lang).in_array(LANGUAGES)
  end

  test 'validation of from_lang' do
    assert validate_presence_of(:from_lang)
    assert validate_inclusion_of(:from_lang).in_array(LANGUAGES)
  end

  test 'has one user' do
    assert have_one(:user)
  end
end
