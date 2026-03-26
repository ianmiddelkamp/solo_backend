class AddTaxRateToLineItemsAndBusinessProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :invoice_line_items,  :tax_rate, :decimal, precision: 5, scale: 2, default: 0, null: false
    add_column :estimate_line_items, :tax_rate, :decimal, precision: 5, scale: 2, default: 0, null: false
    add_column :business_profiles,   :tax_rate, :decimal, precision: 5, scale: 2, default: 0, null: false
  end
end
