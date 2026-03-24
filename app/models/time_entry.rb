class TimeEntry < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :invoice_line_item

  validates :date, presence: true
  validates :hours, presence: true, numericality: { greater_than: 0 }
end