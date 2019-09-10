class AddPassAndDietToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :diet_restrictions, :string
    add_column :clients, :password_digest, :string
  end
end
