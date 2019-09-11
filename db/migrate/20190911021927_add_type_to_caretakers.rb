class AddTypeToCaretakers < ActiveRecord::Migration[5.2]
  def change
    add_column :caretakers, :role, :string
  end
end
