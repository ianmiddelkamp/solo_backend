class ExpandClientsFields < ActiveRecord::Migration[8.1]
  def change
    rename_column :clients, :contact, :contact_name

    add_column :clients, :email1, :string
    add_column :clients, :email2, :string
    add_column :clients, :phone1, :string
    add_column :clients, :phone2, :string
    add_column :clients, :address1, :string
    add_column :clients, :address2, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :postcode, :string
    add_column :clients, :country, :string
  end
end
