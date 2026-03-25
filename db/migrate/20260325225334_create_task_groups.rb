class CreateTaskGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :task_groups do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
