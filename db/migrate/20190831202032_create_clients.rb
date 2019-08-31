class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :username
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone_number
      t.string :needs
      t.string :allergies
      t.string :medications

      t.timestamps
    end
  end
end
