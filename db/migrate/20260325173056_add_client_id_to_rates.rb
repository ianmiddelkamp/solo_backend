class AddClientIdToRates < ActiveRecord::Migration[8.1]
  def change
    add_reference :rates, :client, null: true, foreign_key: true
  end
end
