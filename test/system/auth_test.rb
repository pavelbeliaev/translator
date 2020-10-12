require 'application_system_test_case'

class AuthTest < ApplicationSystemTestCase
  test 'visit index as not authorized' do
    visit root_path

    assert_selector 'p.alert', text: 'You need to sign in or sign up before continuing.'
  end

  test 'sign up' do
    visit new_user_registration_path

    fill_in  'Email',        with: 'bilbo@shire.com'
    fill_in  'Password',     with: 'adventure'
    fill_in  'confirmation', with: 'adventure'
    click_on 'Sign up'

    assert_selector 'p.notice', text: 'A message with a confirmation link has been sent '\
                                      'to your email address. Please follow the link to '\
                                      'activate your account.'
  end

  test 'sign in as not confirmed user' do
    visit new_user_session_path

    create(:user, :bilbo, :not_confirmed)

    fill_in  'Email',    with: 'bilbo@shire.com'
    fill_in  'Password', with: 'adventure'
    click_on 'Log in'

    assert_selector 'p.alert', text: 'You have to confirm your email address before continuing.'
  end

  test 'sign in' do
    visit new_user_session_path

    create(:user, :bilbo)

    fill_in  'Email',    with: 'bilbo@shire.com'
    fill_in  'Password', with: 'adventure'
    click_on 'Log in'

    assert_selector 'p.notice', text: 'Signed in successfully.'
  end
end
