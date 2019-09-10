class List < ApplicationRecord
  belongs_to :client
  has_many :tasks, dependent: :destroy

  validates_presence_of :name
end
