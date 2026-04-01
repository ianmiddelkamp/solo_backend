class EstimateLineItem < ApplicationRecord
  belongs_to :estimate
  belongs_to :task, optional: true

  validates :hours, :rate, :amount, presence: true

  def effective_amount
    return amount unless task&.status == 'done'
    actual = task.actual_hours.to_f
    (actual * rate).round(2)
  end
end
