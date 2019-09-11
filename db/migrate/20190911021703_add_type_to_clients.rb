class AddTypeToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :role, :string
  end
end
