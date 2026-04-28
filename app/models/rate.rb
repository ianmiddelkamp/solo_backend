class Rate < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project, optional: true
  belongs_to :client, optional: true

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
end