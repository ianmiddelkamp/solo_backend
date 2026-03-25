class TaskGroup < ApplicationRecord
  belongs_to :project
  has_many :tasks, -> { order(:position) }, dependent: :destroy

  validates :title, presence: true

  before_create :set_position

  private

  def set_position
    self.position ||= (project.task_groups.maximum(:position) || 0) + 1
  end
end
