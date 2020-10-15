require 'test_helper'
require 'azure_client'

class AzureClientTest < ActiveSupport::TestCase
  def setup
    account = create(:account, to_lang: 'es')
    @translator = AzureClient.new(account)
  end

  test '#translate specific from-to' do
    VCR.use_cassette('azure_client/en-ru') do
      subj = @translator.translate('Hello world!', 'en', 'ru')

      assert_equal 'Всем привет!', subj
    end
  end

  test '#translate skip FROM (language auto-detection)' do
    VCR.use_cassette('azure_client/nil-ru') do
      subj = @translator.translate('Hello world!', nil, 'ru')

      assert_equal 'Всем привет!', subj
    end
  end

  test '#translate skip TO (use account defaults)' do
    VCR.use_cassette('azure_client/nil-es') do
      subj = @translator.translate('Hello world!', nil, nil)

      assert_equal '¡Hola mundo!', subj
    end
  end

  test '#translate use wrong TO' do
    VCR.use_cassette('azure_client/nil-rus') do
      assert_raises AzureClient::APIError do
        @translator.translate('Hello world!', nil, 'rus')
      end
    end
  end
end
