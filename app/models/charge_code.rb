class ChargeCode < ApplicationRecord
  belongs_to :user
  has_many :time_entries

  validates :code, presence: true, uniqueness: { scope: :user_id }
  validates :rate, numericality: { greater_than: 0, allow_nil: true }

  def as_json(options = {})
    super(options).tap do |h|
      h['rate'] = rate.to_f if h.key?('rate') && rate
    end
  end
end
