class RenameLangOnAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :lang, :to_lang
  end
end
