class Account < ApplicationRecord
  has_one :user
  validates :lang, presence: true
end
