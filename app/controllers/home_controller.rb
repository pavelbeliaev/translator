class HomeController < ApplicationController
  def index
    return unless request.post?

    vendor = translation_params[:vendor]
    from   = translation_params[:from]
    to     = translation_params[:to]
    @text  = translation_params[:text]

    @result = translator.translate(vendor, @text, from, to)

    update_session(vendor, from, to)
  end

  private

  def translator
    @translator ||= Translation.new(current_account)
  end

  def translation_params
    params.require(:translation).permit(:vendor, :text, :from, :to)
  end

  def update_session(vendor, from, to)
    session['lang'] ||= {}

    session['vendor']       = vendor
    session['lang']['from'] = from
    session['lang']['to']   = to
  end
end
