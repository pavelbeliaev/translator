module HomeHelper
  LANGUAGES = [
    'en',
    'ru'
  ].freeze

  def options_lang_from(from)
    options_for_select(LANGUAGES, from || 'en')
  end

  def options_lang_to(to)
    options_for_select(LANGUAGES, to || 'ru')
  end
end
