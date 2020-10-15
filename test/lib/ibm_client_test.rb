require 'test_helper'
require 'ibm_client'

class IBMClientTest < ActiveSupport::TestCase
  def setup
    account = create(:account, to_lang: 'es')
    @translator = IBMClient.new(account)
  end

  test '#translate specific from-to' do
    VCR.use_cassette('ibm_client/en-ru') do
      subj = @translator.translate('Hello world!', 'en', 'ru')

      assert_equal 'Привет, мир!', subj
    end
  end

  test '#translate skip TO (use account defaults)' do
    VCR.use_cassette('ibm_client/en-es') do
      subj = @translator.translate('Hello world!', 'en', nil)

      assert_equal '¡Hola mundo!', subj
    end
  end

  test '#translate use wrong TO' do
    VCR.use_cassette('ibm_client/en-rus') do
      assert_raises IBMClient::APIError do
        @translator.translate('Hello world!', 'en', 'rus')
      end
    end
  end
end
