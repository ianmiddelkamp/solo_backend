class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_line_items, dependent: :destroy
  has_many :time_entries, through: :invoice_line_items
  has_one_attached :pdf

  validates :status, inclusion: { in: %w[pending sent paid] }
  validates :amount_paid, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def number
    "INV-#{id.to_s.rjust(4, '0')}"
  end

  def outstanding
    (total || 0) - (amount_paid || 0)
  end
end