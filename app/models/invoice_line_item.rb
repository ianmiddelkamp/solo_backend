class InvoiceLineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :time_entry

  before_validation :set_amount

  validates :hours, :rate, :amount, presence: true

  private

  def set_amount
    self.hours ||= time_entry.hours
    self.rate  ||= time_entry.project.rates.first&.rate || 0
    self.amount = hours * rate
  end
end