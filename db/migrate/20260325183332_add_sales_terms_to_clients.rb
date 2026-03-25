class AddSalesTermsToClients < ActiveRecord::Migration[8.1]
  def change
    add_column :clients, :sales_terms, :string, default: "NET 15"
  end
end
