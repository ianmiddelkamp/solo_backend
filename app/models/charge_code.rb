class ChargeCode < ApplicationRecord
  belongs_to :user
  has_many :time_entries

  validates :code, presence: true, uniqueness: { scope: :user_id }
  validates :rate, numericality: { greater_than: 0, allow_nil: true }

end
