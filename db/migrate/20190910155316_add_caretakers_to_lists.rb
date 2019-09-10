class AddCaretakersToLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :lists, :caretaker, foreign_key: true
  end
end
