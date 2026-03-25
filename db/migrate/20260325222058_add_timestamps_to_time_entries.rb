class AddTimestampsToTimeEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :time_entries, :started_at, :datetime
    add_column :time_entries, :stopped_at, :datetime
  end
end
