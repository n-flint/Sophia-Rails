class AddTypeToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :type, :string
  end
end
