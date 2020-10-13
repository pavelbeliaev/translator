class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string 'lang', null: false, default: 'ru'
      t.timestamps
    end
  end
end
