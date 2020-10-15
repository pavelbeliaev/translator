module HomeHelper
  def options_for_from_lang
    options_for_select(LANGUAGES, session.dig('lang', 'from') || current_account.from_lang)
  end

  def options_for_to_lang
    options_for_select(LANGUAGES, session.dig('lang', 'to') || current_account.to_lang)
  end
end
