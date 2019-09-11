class AddTypeToCaretakers < ActiveRecord::Migration[5.2]
  def change
    add_column :caretakers, :type, :string
  end
end
