class AddChargeCodes < ActiveRecord::Migration[8.1]
  def change
    create_table :charge_codes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code, null: false
      t.string :description
      t.decimal :rate, precision: 10, scale: 2
      t.timestamps
    end

    add_index :charge_codes, [:user_id, :code], unique: true

    add_reference :time_entries, :charge_code, foreign_key: true
    add_reference :time_entries, :client, foreign_key: true
    change_column_null :time_entries, :project_id, true
  end
end
