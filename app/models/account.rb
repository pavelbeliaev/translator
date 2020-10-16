class Account < ApplicationRecord
  has_one :user, dependent: :destroy
  validates :to_lang, :from_lang, presence: true, inclusion: LANGUAGES
  validate :translation_model

  private

  def translation_model
    return unless from_lang == to_lang

    errors.add(:from_lang, "can't be the same as To")
    errors.add(:to_lang, "can't be te same as From")
  end
end
