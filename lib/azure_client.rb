class AzureClient
  # The client for Translator v3.0 API from Microsoft
  class APIError < StandardError; end

  ENDPOINT = 'https://api.cognitive.microsofttranslator.com/'.freeze

  def initialize(account)
    @account = account
  end

  def translate(text, from, to)
    payload = [{ 'Text' => text.squish }].to_json

    case call_api(payload, from, to)
    in [{detectedLanguage: {language: lang}, translations: [{text: result}]}]
      result # right now this branch is redundant, we'll utilize it later
    in [{translations: [{text: result}]}]
      result
    in {error: {code: code, message: message}}
      raise APIError, message
    end
  end

  private

  def call_api(payload, from, to)
    params = { 'api-version': '3.0', from: from, to: to || @account.to_lang }.compact

    resp = Faraday.new(
      url: ENDPOINT,
      params: params,
      headers: headers
    ).post('translate', payload)

    raise(APIError, resp.body) unless resp.success?

    JSON.parse(resp.body, symbolize_names: true)
  end

  def headers
    {
      'Ocp-Apim-Subscription-Key':    Rails.application.credentials.azure_key,
      'Ocp-Apim-Subscription-Region': Rails.application.credentials.azure_region,
      'Content-Type':                 'application/json; charset=UTF-8'
    }
  end
end
