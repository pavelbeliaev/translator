require 'azure_client'
require 'ibm_client'

class Translation
  class UnknownVendor < StandardError; end

  def initialize(account)
    @account = account
  end

  def translate(vendor, text, from, to)
    validate_vendor(vendor)
    init_client_for(vendor)

    @client.translate(text, from, to)
  end

  private

  def validate_vendor(vendor)
    return if VENDORS.include?(vendor)

    raise UnknownVendor
  end

  def init_client_for(vendor)
    return if vendor == @current_vendor

    @client = case vendor
              when 'azure'
                AzureClient.new(@account)
              when 'ibm'
                IBMClient.new(@account)
              end

    @current_vendor = vendor
  end
end
