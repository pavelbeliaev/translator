class AddFromLangToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :from_lang, :string, default: 'en', null: false
  end
end
