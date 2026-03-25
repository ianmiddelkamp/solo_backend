class CreateTimerSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :timer_sessions do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :started_at, null: false
      t.datetime :stopped_at
      t.string :description

      t.timestamps
    end
  end
end
