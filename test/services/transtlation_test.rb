require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  def setup
    account = create(:account)
    @translator = Translation.new(account)
  end

  test '#translate azure' do
    mock = Minitest::Mock.new
    mock.expect :translate, true, ['text', 'en', 'ru']

    AzureClient.stub :new, mock do
      @translator.translate('azure', 'text', 'en', 'ru')
    end

    assert_mock mock
  end

  test '#translate ibm' do
    mock = Minitest::Mock.new
    mock.expect :translate, true, ['text', 'en', 'ru']

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

  test '#init_vendor cache the vendor' do
    @translator.instance_variable_set('@current_vendor', 'azure')

    assert_nil @translator.send(:init_client_for, 'azure')
  end

  test '#init_vendor initialize a new vendor' do
    @translator.instance_variable_set('@current_vendor', 'azure')

    assert_equal @translator.send(:init_client_for, 'ibm'), 'ibm'
  end
end
