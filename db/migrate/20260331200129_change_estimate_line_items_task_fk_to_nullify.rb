class ChangeEstimateLineItemsTaskFkToNullify < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :estimate_line_items, :tasks
    add_foreign_key :estimate_line_items, :tasks, on_delete: :nullify
  end
end
