class EstimateLineItem < ApplicationRecord
  belongs_to :estimate
  belongs_to :task, optional: true

  validates :hours, :rate, :amount, presence: true
end
