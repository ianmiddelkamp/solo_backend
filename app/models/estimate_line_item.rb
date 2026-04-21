class EstimateLineItem < ApplicationRecord
  belongs_to :estimate
  belongs_to :task, optional: true

  validates :hours, :rate, :amount, presence: true

  def as_json(options = {})
    super(options).tap do |h|
      h['hours']  = hours.to_f  if h.key?('hours')
      h['rate']   = rate.to_f   if h.key?('rate')
      h['amount'] = amount.to_f if h.key?('amount')
    end
  end

end
