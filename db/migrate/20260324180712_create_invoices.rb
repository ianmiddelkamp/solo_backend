class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :client, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :total, precision: 10, scale: 2
      t.string :status, default: "pending"
      t.string :pdf_url

      t.timestamps
    end
  end
end
