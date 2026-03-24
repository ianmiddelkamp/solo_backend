class CreateRates < ActiveRecord::Migration[8.1]
  def change
    create_table :rates do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.decimal :rate, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
