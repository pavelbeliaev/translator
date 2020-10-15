require 'application_system_test_case'

class TranslationTest < ApplicationSystemTestCase
  def setup
    sign_in create(:user)
    visit root_path
  end

  test 'ru - en with Azure' do
    VCR.use_cassette('azure_client/ru-en') do
      choose 'Azure'
      select('ru', from: 'translation_from')
      select('en', from: 'translation_to')
      fill_in 'input', with: 'Всем привет!'

      click_on 'Translate'

      assert_selector '#output', text: 'Hello world!'
    end
  end

  test 'en - ru with Azure' do
    VCR.use_cassette('azure_client/en-ru') do
      choose 'Azure'
      select('en', from: 'translation_from')
      select('ru', from: 'translation_to')
      fill_in 'input', with: 'Hello world!'

      click_on 'Translate'

      assert_selector '#output', text: 'Всем привет!'
    end
  end

  test 'ru - en with IBM' do
    VCR.use_cassette('ibm_client/ru-en') do
      choose 'Ibm'
      select('ru', from: 'translation_from')
      select('en', from: 'translation_to')
      fill_in 'input', with: 'Всем привет!'

      click_on 'Translate'

      assert_selector '#output', text: 'Hi, everybody!'
    end
  end

  test 'en - ru with IBM' do
    VCR.use_cassette('ibm_client/en-ru') do
      choose 'Ibm'
      select('en', from: 'translation_from')
      select('ru', from: 'translation_to')
      fill_in 'input', with: 'Hello world!'

      click_on 'Translate'

      assert_selector '#output', text: 'Привет, мир!'
    end
  end

  test 'remembers the selected translation model (cache it in the session)' do
    VCR.use_cassette('azure_client/ru-en') do
      assert has_select?('translation_from', selected: 'en')
      assert has_select?('translation_to', selected: 'ru')

      select('ru', from: 'translation_from')
      select('en', from: 'translation_to')
      fill_in 'input', with: 'Всем привет!'

      click_on 'Translate'

      assert_selector '#output', text: 'Hello world!'

      visit root_path

      assert has_select?('translation_from', selected: 'ru')
      assert has_select?('translation_to', selected: 'en')
    end
  end

  test 'remembers the selected vendor' do
    VCR.use_cassette('ibm_client/en-ru') do
      assert_selector '#translation_vendor_azure[checked=checked]'

      choose 'Ibm'
      fill_in 'input', with: 'Hello world!'

      click_on 'Translate'

      assert_selector '#output', text: 'Привет, мир!'

      visit root_path

      assert_selector '#translation_vendor_ibm[checked=checked]'
    end
  end

  test 'clear button' do
    fill_in 'input', with: 'Hello'
    assert_equal 'Hello', find('#input').value

    click_on 'Clear'

    assert_equal '', find('#input').value
  end
end
