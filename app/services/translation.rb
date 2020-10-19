require 'azure_client'
require 'ibm_client'

class Translation
  class UnknownVendor < StandardError; end

  def initialize(account)
    @account = account
  end

  def translate(vendor, text, from, to)
    validate_vendor(vendor)

    Rails.cache.fetch([vendor, text, from, to]) do
      client_for(vendor).translate(text, from, to)
    end
  end

  private

  def validate_vendor(vendor)
    return if VENDORS.include?(vendor)

    raise UnknownVendor
  end

  def client_for(vendor)
    case vendor
    when 'azure'
      AzureClient.new(@account)
    when 'ibm'
      IBMClient.new(@account)
    end
  end
end
