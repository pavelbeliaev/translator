require 'azure_client'

class HomeController < ApplicationController
  def index
    return unless request.post?

    @text = translation_params[:text]
    @from = translation_params[:from]
    @to   = translation_params[:to]

    @result = translator.translate(@text, @from, @to)
  end

  private

  def translator
    @translator ||= AzureClient.new(current_account)
  end

  def translation_params
    params.require(:translation).permit(:text, :from, :to)
  end
end
