class CreateCaretakers < ActiveRecord::Migration[5.2]
  def change
    create_table :caretakers do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.string :abilities

      t.timestamps
    end
  end
end
