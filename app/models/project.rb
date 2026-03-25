class Project < ApplicationRecord
  belongs_to :client
  has_many :time_entries
  has_many :rates
  has_many :task_groups, -> { order(:position) }, dependent: :destroy

  validates :name, presence: true

  def current_rate
    rates.first&.rate
  end
end