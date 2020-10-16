class AccountController < ApplicationController
  def index; end

  def update
    clear_session if current_account.update(account_params)

    render :index
  end

  private

  def account_params
    params.require(:account).permit(:from_lang, :to_lang)
  end

  def clear_session
    session['lang'] = nil
  end
end
