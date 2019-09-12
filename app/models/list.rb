class List < ApplicationRecord
  belongs_to :client
  belongs_to :caretaker, optional: true
  has_many :tasks, dependent: :destroy

  validates_presence_of :name
end
