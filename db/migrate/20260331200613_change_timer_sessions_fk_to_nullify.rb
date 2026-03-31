class ChangeTimerSessionsFkToNullify < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :timer_sessions, :tasks
    add_foreign_key :timer_sessions, :tasks, on_delete: :nullify
  end
end
