require 'application_system_test_case'

class TranslationTest < ApplicationSystemTestCase
  def setup
    sign_in create(:user)
    visit root_path
  end

  test 'ru - en' do
    VCR.use_cassette('ru-en translation') do
      select('ru', from: 'translation_from')
      select('en', from: 'translation_to')
      fill_in 'input', with: 'Привет, как дела?'

      click_on 'Translate'

      assert_selector '.output', text: 'Hi how are you?'
    end
  end

  test 'en - ru' do
    VCR.use_cassette('en-ru translation') do
      select('en', from: 'translation_from')
      select('ru', from: 'translation_to')
      fill_in 'input', with: 'Hello, how are you?'

      click_on 'Translate'

      assert_selector '.output', text: 'Привет как дела?'
    end
  end

  test 'clear button' do
    fill_in 'input', with: 'Hello'
    assert_selector '.input', text: 'Hello'

    click_on 'Clear'

    assert_selector '.input', text: ''
  end
end
