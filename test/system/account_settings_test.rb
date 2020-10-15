require 'application_system_test_case'

class AccountSettingsTest < ApplicationSystemTestCase
  def setup
    @account = create(:account, from_lang: 'en', to_lang: 'ru')
    user     = create(:user, account: @account)

    sign_in user

    visit account_path
  end

  test 'try to set the same lang to both fields' do
    select('en', from: 'account_to_lang')

    click_on 'Update'

    assert_selector 'ul.errors'

    @account.reload

    assert_equal('en', @account.from_lang)
    assert_equal('ru', @account.to_lang)
  end

  test 'try to update lang model with correct values' do
    select('ru', from: 'account_from_lang')
    select('en', from: 'account_to_lang')

    click_on 'Update'

    assert_no_selector 'ul.errors'

    @account.reload

    assert_equal('ru', @account.from_lang)
    assert_equal('en', @account.to_lang)
  end
end
