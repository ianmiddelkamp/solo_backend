class AddProjectIsArchived < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :is_archived, :boolean, default: false, null: false
  end
end
