class User < ApplicationRecord
  belongs_to :account
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true
  before_validation :create_defaults, on: :create

  def create_defaults
    return if account.present?
    build_account
  end
end
