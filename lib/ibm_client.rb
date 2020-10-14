class IBMClient
  # The client for IBM Cloud translator API
  class APIError < StandardError; end

  ENDPOINT = 'https://api.eu-gb.language-translator.watson.cloud.ibm.com/instances/df6e14c4-7565-4987-89ed-f0bed39d291d'.freeze

  def initialize(account)
    @account = account
  end

  def translate(text, from, to)
    to = to || @account.lang
    payload = { text: [text.squish], model_id: "#{from}-#{to}" }.to_json

    case call_api(payload)
    #{"translations": [{"translation": "Hola, mundo."}]}
    in {translations: [{translation: result}]}
      result
    #{"code" : 404, "error" : "Model not found."}
    in {code: code, error: message}
      raise APIError.new(message)
    end
  end

  private

  def call_api(payload)
    conn = Faraday.new(
      url: ENDPOINT,
      params: params,
      headers: headers
    )
    conn.basic_auth('apikey', Rails.application.credentials.ibm_key)
    resp = conn.post('v3/translate', payload)

    raise APIError.new(resp.body) unless resp.success?

    JSON.parse(resp.body, symbolize_names: true)
  end

  def params
    { version: '2018-05-01' }
  end

  def headers
    { 'Content-Type':  'application/json; charset=UTF-8' }
  end
end
