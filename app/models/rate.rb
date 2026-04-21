class Rate < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project, optional: true
  belongs_to :client, optional: true

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def as_json(options = {})
    super(options).tap do |h|
      h['rate'] = rate.to_f if h.key?('rate')
    end
  end
end