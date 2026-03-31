class ChangeEstimateLineItemNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :estimate_line_items, :task_id, true
  end
end
