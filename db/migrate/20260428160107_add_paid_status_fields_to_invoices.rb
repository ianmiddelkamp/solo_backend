class AddPaidStatusFieldsToInvoices < ActiveRecord::Migration[8.1]
  def change
    add_column :invoices, :paid_at, :datetime
    add_column :invoices, :amount_paid, :decimal, precision: 10, scale: 2
  end
end
