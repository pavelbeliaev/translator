class HomeController < ApplicationController
  def index
    return unless request.post?

    @vendor = translation_params[:vendor]
    @text   = translation_params[:text]
    @from   = translation_params[:from]
    @to     = translation_params[:to]

    @result = translator.translate(@vendor, @text, @from, @to)
  end

  private

  def translator
    @translator ||= Translation.new(current_account)
  end

  def translation_params
    params.require(:translation).permit(:vendor, :text, :from, :to)
  end
end
