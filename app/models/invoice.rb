class Invoice < ApplicationRecord
  belongs_to :client
  has_many :invoice_line_items, dependent: :destroy
  has_many :time_entries, through: :invoice_line_items

  validates :status, inclusion: { in: %w[pending sent paid] }
end