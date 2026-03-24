class CreateInvoiceLineItems < ActiveRecord::Migration[8.1]
   def change
    create_table :invoice_line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :time_entry, null: false, foreign_key: true
      t.text :description
      t.decimal :hours, precision: 5, scale: 2
      t.decimal :rate, precision: 10, scale: 2
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
