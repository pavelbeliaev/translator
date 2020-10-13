class CreateAccountsForUsers < ActiveRecord::Migration[6.0]
  def up
    User.where(account_id: nil).find_each do |u|
      a = u.build_account
      a.save(validate: false)
    end
  end

  def down
  end
end
