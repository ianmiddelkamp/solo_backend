class InvoiceLineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :time_entry

  before_validation :set_amount

  validates :hours, :rate, :amount, presence: true

  def as_json(options = {})
    super(options).tap do |h|
      h['hours']  = hours.to_f  if h.key?('hours')
      h['rate']   = rate.to_f   if h.key?('rate')
      h['amount'] = amount.to_f if h.key?('amount')
    end
  end

  private

  def set_amount
    self.hours ||= time_entry.hours
    self.rate  ||= time_entry.project.rates.first&.rate || 0
    self.amount = hours * rate
  end
end