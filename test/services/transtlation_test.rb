require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  include CachingHelper
  def setup
    account = create(:account)
    @translator = Translation.new(account)
  end

  test '#translate azure' do
    mock = Minitest::Mock.new
    mock.expect :translate, true, %w[text en ru]

    AzureClient.stub :new, mock do
      @translator.translate('azure', 'text', 'en', 'ru')
    end

    assert_mock mock
  end

  test '#translate ibm' do
    mock = Minitest::Mock.new
    mock.expect :translate, true, %w[text en ru]

    IBMClient.stub :new, mock do
      @translator.translate('ibm', 'text', 'en', 'ru')
    end

    assert_mock mock
  end

  test '#translate unknown vendor' do
    assert_raises Translation::UnknownVendor do
      @translator.translate('none', 'text', 'en', 'ru')
    end
  end

  test '#translate caching' do
    mock = Minitest::Mock.new
    mock.expect :translate, 'привет', %w[hello en ru]

    IBMClient.stub :new, mock do
      assert_equal('привет', @translator.translate('ibm', 'hello', 'en', 'ru'))
      assert_raise MockExpectationError do
        assert_equal('привет', @translator.translate('ibm', 'hello', 'en', 'ru'))
        mock.verify
      end
    end
  end
end
